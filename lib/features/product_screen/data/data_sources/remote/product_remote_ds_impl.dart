import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/product_screen/data/data_sources/remote/product_remote_ds.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProductRemoteDs)
class ProductRemoteDsImpl implements ProductRemoteDs {
  ApiManager apiManager;

  ProductRemoteDsImpl(this.apiManager);

  @override
  Future<ProductModel> getProduct({String? catId}) async {
    try {
      final result = await apiManager.getData(
          endPoint: EndPoints.products,
          queryParameters: catId == null ? null : {"category[in]": catId});
      return
        ProductModel.fromJson(result.data);
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }


  @override
  Future<CartModel> addToCart({String? productId}) async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.postData(EndPoints.cart, data: {
        "productId": productId
      }, headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return CartModel.fromJson(response.data);  // Parsing JSON response
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }

  @override
  Future<ProductModel> searchProduct({String? query}) async {
    try {
      // Step 1: Get all products (or optionally a cached set)
      final result = await getProduct();

      // Step 2: Filter by query locally

      final allProducts = result.data ?? [];

      final filtered = allProducts.where((product) {
        final title = product.title?.toLowerCase() ?? '';
        final searchQuery = query?.toLowerCase() ?? '';
        return title.contains(searchQuery);
      }).toList();

      return ProductModel(
        results: filtered.length,
        data: filtered,
        metadata: result.metadata,
      );
    } catch (e) {
      throw Exception("Search failed: ${e.toString()}");
    }
  }

}

