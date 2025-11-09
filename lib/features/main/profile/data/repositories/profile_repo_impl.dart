import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';

import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';

import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

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
      {required AddressData model}) async {
    try {
      var result = await profileRemoteDs.addAddress(model: model);
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
  Future<Either<RouteFailures, AddressModel>> deleteAddress(String? id) async {
    try {
      var result = await profileRemoteDs.deleteAddresses(id);
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, AuthModel>> updateUserProfile({String? name,
    String? email,
    String? phone}) async{
    try {
      var result = await profileRemoteDs.updateUserProfile(name: name,email: email,phone: phone);
      final prefs = await SharedPrefsHelper.getInstance();
      await prefs.setValue<String>('name', result.user?.name ?? '');
      await prefs.setValue<String>('email', result.user?.email ?? '');
      await prefs.setValue<String>('phone', result.user?.phone ?? phone ?? '');
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }
}
