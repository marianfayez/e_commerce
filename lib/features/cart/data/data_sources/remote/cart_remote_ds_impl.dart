import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/remote/cart_remote_ds.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDs)
class CartRemoteDsImpl implements CartRemoteDs {
  ApiManager apiManager;

  CartRemoteDsImpl(this.apiManager);

  @override
  Future<CartModel> getCart() async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.getData(
          endPoint: EndPoints.cart, headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return CartModel.fromJson(response.data); // Parsing JSON response
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
  Future<CartModel> removeCartItem(String? productId) async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.deleteRequest(EndPoints.deleteCartItem(productId),
          headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return CartModel.fromJson(response.data); // Parsing JSON response
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
  Future<CartModel> updateCartItems(String? productId, int? newQuantity) async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.putData(EndPoints.updateCartItem(productId),
          body: {
            'count': newQuantity,
          },
          headers: {
            "token": token,
          });
      if (response.data is Map<String, dynamic>) {
        return CartModel.fromJson(response.data); // Parsing JSON response
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }
}