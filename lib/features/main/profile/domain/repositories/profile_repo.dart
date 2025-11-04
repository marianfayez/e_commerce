import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileRepo {
  Future<Either<RouteFailures, AuthModel>> profile();
  Future<Either<RouteFailures, AddressModel>> addAddress(
      {required String name, required String details,required String phone,required String city});
  Future<Either<RouteFailures, AddressModel>> getAddresses();
  Future<Either<RouteFailures, AddressModel>> deleteAddress( String? id);

}
