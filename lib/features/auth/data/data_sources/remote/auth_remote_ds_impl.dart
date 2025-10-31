import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDs)
class AuthRemoteDsImpl implements AuthRemoteDs{

  ApiManager apiManager;
  AuthRemoteDsImpl(this.apiManager);

  @override
  Future<AuthModel> signUp({SignUpRequestModel? request}) async{

    try {
      final response = await apiManager.postData(
         EndPoints.signUp,
        data: request!.toJson(),
      );
      return AuthModel.fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(errorMessage); // or rethrow with ServerFailure if using Either
    }

  }

  @override
  Future<AuthModel> logIn({String? email, String? password}) async{
    try {
      final response = await apiManager.postData(
        EndPoints.login,
        data:{
          "email":email,
          "password":password
        }

      );
      print(response.data);
      return AuthModel.fromJson(response.data);

    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(errorMessage); // or rethrow with ServerFailure if using Either
    }

  }


}