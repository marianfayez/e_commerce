import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRepo {
  Future<Either<RouteFailures, AuthModel>> profile();

  Future<Either<RouteFailures, AddressModel>> addAddress(
      {required AddressData model});

  Future<Either<RouteFailures, AddressModel>> getAddresses();

  Future<Either<RouteFailures, AddressModel>> deleteAddress(String? id);

  Future<Either<RouteFailures, AuthModel>> updateUserProfile(
      {String? name, String? email, String? phone});

  Future<Either<RouteFailures, AuthModel>> changePassword(
      ChangePasswordModel model);
}
