import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';

abstract class AuthRemoteDs{

  Future<AuthModel>signUp({SignUpRequestModel? request});
  Future<AuthModel>logIn({String? email,String? password});

}