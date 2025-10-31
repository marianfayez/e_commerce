import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/product_details/data/data_sources/remote/product_details_ds.dart';
import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsDs)
class ProductDetailsDsImpl implements ProductDetailsDs {
  ApiManager apiManager;

  ProductDetailsDsImpl(this.apiManager);

  @override
  Future<ProductDetailsModel> getProductDetails(String productId) async {
    try {
      final result = await apiManager.getData(
          endPoint: EndPoints.productDetails(productId));
      return ProductDetailsModel.fromJson(result.data);
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }
}
