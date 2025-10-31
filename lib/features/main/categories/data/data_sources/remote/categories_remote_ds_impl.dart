import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/main/categories/data/data_sources/remote/categories_remote_ds.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDs)
class CategoriesRemoteDsImpl implements CategoriesRemoteDs{

  ApiManager apiManager;
  CategoriesRemoteDsImpl(this.apiManager);

  @override
  Future<CategoriesModel> getSubCategories(String id) async{
    try{
      var result =await apiManager.getData(endPoint: EndPoints.subCategories(id));
      return CategoriesModel.fromJson(result.data);
    }on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }

  }


}