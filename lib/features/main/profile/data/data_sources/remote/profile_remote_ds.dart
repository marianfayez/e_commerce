import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';

abstract class ProfileRemoteDs {
  Future<AuthModel> profile();

  Future<AuthModel> updateUserProfile({String? name,
    String? email,
    String? phone});

  Future<AddressModel> addAddress({required AddressData model});

  Future<AddressModel> getAddresses();

  Future<AddressModel> deleteAddresses(String? id);
}
