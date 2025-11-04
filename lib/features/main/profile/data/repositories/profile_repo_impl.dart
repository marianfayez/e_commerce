import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  ProfileRemoteDs profileRemoteDs;
  ProfileRepoImpl(this.profileRemoteDs);

  @override
  Future<Either<RouteFailures, AuthModel>> profile() async {
    try {
      var result = await profileRemoteDs.profile();
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, AddressModel>> addAddress(
      {required String name,
      required String details,
      required String phone,
      required String city}) async {
    try {
      var result = await profileRemoteDs.addAddress(
        name: name,
        details: details,
        phone: phone,
        city: city,
      );
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, AddressModel>> getAddresses() async {
    try {
      var result = await profileRemoteDs.getAddresses();
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, AddressModel>> deleteAddress(String? id) async{
    try {
      var result = await profileRemoteDs.deleteAddresses(id);
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }
}
