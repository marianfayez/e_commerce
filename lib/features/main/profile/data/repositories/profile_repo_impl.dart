import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo{

  ProfileRemoteDs profileRemoteDs;
  ProfileRepoImpl(this.profileRemoteDs);

  @override
  Future<Either<RouteFailures, AuthModel>> Profile() async{
    try{
      var result = await profileRemoteDs.profile();
      return Right(result);
    }catch(e){
      return Left(RemoteFailures(e.toString()));
    }
  }
}