import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/main/favorites/data/data_sources/remote/add_to_favorite_ds.dart';
import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddToFavoriteDs)
class AddToFavoriteDsImpl implements AddToFavoriteDs{
  ApiManager apiManager;
  AddToFavoriteDsImpl(this.apiManager);

  @override
  Future<WishlistModel> addToFavorite(String? productId) async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.postData(EndPoints.addToFavorite, data: {
        "productId": productId
      }, headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return WishlistModel.fromJson(response.data);  // Parsing JSON response
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
  Future<FavoriteProductModel > getFavoriteProduct() async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = await prefs.getValue<String>('token');

      var response = await apiManager.getData(
          endPoint: EndPoints.addToFavorite, headers: {
        "token": token,

      });
      if (response.data is Map<String, dynamic>) {
        return FavoriteProductModel .fromJson(response.data); // Parsing JSON response
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
  Future<DeleteFavoriteResponse > removeFavoriteProduct(String? productId) async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager.deleteRequest(
           EndPoints.removeFromFavorite(productId), headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return DeleteFavoriteResponse  .fromJson(response.data); // Parsing JSON response
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