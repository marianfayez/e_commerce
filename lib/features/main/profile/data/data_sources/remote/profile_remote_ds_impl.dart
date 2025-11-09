import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/auth/data/data_sources/remote/auth_remote_ds.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImpl implements ProfileRemoteDs {
  ApiManager apiManager;

  ProfileRemoteDsImpl(this.apiManager);

  @override
  Future<AuthModel> profile() async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();

      final token = prefs.getValue<String>('token');
      final name = prefs.getValue<String>('name');
      final email = prefs.getValue<String>('email');
      final phone = prefs.getValue<String>('phone');
      if (name == null || email == null || token == null) {
        throw Exception('User data not found in local storage');
      }
      final user = User(name: name, email: email, phone: phone);
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

  @override
  Future<AddressModel> addAddress({required AddressData model}) async {
    try {
      //  print("📦 SENDING DATA TO API: name=$name, details=$details, phone=$phone, city=$city");
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response = await apiManager
          .postData(EndPoints.addAddress, data: model.toJson(), headers: {
        "token": token,
      });
      final addressModel = AddressModel.fromJson(response.data);
      return addressModel;
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }

  @override
  Future<AddressModel> getAddresses() async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response =
          await apiManager.getData(endPoint: EndPoints.addAddress, headers: {
        "token": token,
      });

      if (response.data is Map<String, dynamic>) {
        return AddressModel.fromJson(response.data);
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      throw Exception(e.error?.toString() ?? 'Unknown error occurred');
    }
  }

  @override
  Future<AddressModel> deleteAddresses(String? id) async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');

      var response =
          await apiManager.deleteRequest(EndPoints.deleteAddress(id), headers: {
        "token": token,
      });
      if (response.data is Map<String, dynamic>) {
        return AddressModel.fromJson(response.data); // Parsing JSON response
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (e) {
      final errorMessage = e.error?.toString() ?? 'Unknown error occurred';
      throw Exception(
          errorMessage); // or rethrow with ServerFailure if using Either
    }
  }

  @override
  Future<AuthModel> updateUserProfile({String? name,
    String? email,
    String? phone,}) async {
    try {
      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');
      final currentName = prefs.getValue<String>('name');
      final currentEmail = prefs.getValue<String>('email');

      final Map<String, dynamic> body = {};
      if (currentName != null) body['name'] = name;
      if (currentEmail != null && email !=currentEmail) {
        body['email'] = email;
      }
      if (body.isEmpty) {
        throw Exception('No fields provided to update');
      }
      var response = await apiManager
          .putData(EndPoints.updateProfile, body: body, headers: {
        "token": token,
      });
      final authModel = AuthModel.fromJson(response.data);

      return authModel;
    } on DioException catch (e) {
      String message = "Something went wrong";
      if (e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey("errors")) {
          final errors = data["errors"];
          if (errors is Map && errors.containsKey("msg")) {
            message = errors["msg"];
          } else if (errors is String) {
            message = errors;
          }
        } else if (data is Map && data.containsKey("message")) {
          message = data["message"];
        }
      }
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
