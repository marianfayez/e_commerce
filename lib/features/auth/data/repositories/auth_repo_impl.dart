import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo{

  AuthRemoteDs authRemoteDs;
  AuthRepoImpl(this.authRemoteDs);

  @override
  Future<Either<RouteFailures, AuthModel>> signUp( {required SignUpRequestModel request}) async{
    try{
      print(request.toJson());
      var result = await authRemoteDs.signUp(request:request);
      return Right(result);
    }catch(e){
      return Left(RemoteFailures(e.toString()));
    }

  }

  @override
  Future<Either<RouteFailures, AuthModel>> logIn({required String email, required String password}) async{
    try{
      var result = await authRemoteDs.logIn(email: email,password: password);
      var prefs=await SharedPrefsHelper.getInstance();
      await prefs.setValue<String>("token", result.token??"");
      return Right(result);
    }catch(e){
      return Left(RemoteFailures(e.toString()));
    }

  }


}