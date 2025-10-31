import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImpl implements ProfileRemoteDs{

  ApiManager apiManager;
  ProfileRemoteDsImpl(this.apiManager);

  @override
  Future<AuthModel> profile() async{
    try {
      final prefs = await SharedPrefsHelper.getInstance();

      final token = prefs.getValue<String>('token');
      final name = prefs.getValue<String>('name');
      final email = prefs.getValue<String>('email');
      if (name == null || email == null || token == null) {
        throw Exception('User data not found in local storage');
      }
      final user = User(name: name, email: email);
      final authModel = AuthModel(
        message: 'Profile loaded successfully (local)',
        user: user,
        token: token,
      );
      return authModel;
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }


}