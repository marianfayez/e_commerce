import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/main/home/data/data_sources/remote/home_remote_ds.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDs)
class HomeRemoteDsImpl implements HomeRemoteDs {

  ApiManager apiManager;

  HomeRemoteDsImpl(this.apiManager);

  @override
  Future<CategoriesModel> getCategories() async {
    try {
      final result = await apiManager.getData(endPoint: EndPoints.categories);
      return CategoriesModel.fromJson(result.data);
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }
}
