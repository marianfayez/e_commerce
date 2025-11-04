import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';

abstract class ProfileRemoteDs{

  Future<AuthModel>profile();
  Future<AddressModel>addAddress(
      {String? name, String? details, String? phone, String? city});
  Future<AddressModel> getAddresses();
  Future<AddressModel> deleteAddresses(String? id);


}