import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/api/api_manager.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/resources/endpoints.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/main/profile/data/data_sources/remote/profile_remote_ds.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDs)
class ProfileRemoteDsImpl implements ProfileRemoteDs {
  ApiManager apiManager;

  ProfileRemoteDsImpl(this.apiManager);

  Future<String> _getToken() async {
    final prefs = await SharedPrefsHelper.getInstance();
    final token = prefs.getValue<String>('token');
    if (token == null) throw Exception('User not logged in');
    return token;
  }

  @override
  Future<AuthModel> profile() async {
    try {

      final prefs = await SharedPrefsHelper.getInstance();

      final token = prefs.getValue<String>('token');
      String? name = prefs.getValue<String>('name');
      String? email = prefs.getValue<String>('email');
      String? phone = prefs.getValue<String>('phone');
      print("Cache Check: $name, $email, $phone");
      return AuthModel(
        user: User(
            name: name ?? "",
            email: email ?? "",
            phone: phone ?? ""
        ),
        token: token,
      );
    } on DioException catch (e) {
      throw ServerException(e.toString());

    }
  }

  @override
  Future<AddressModel> addAddress({required AddressData model}) async {
    try {
      final token = await _getToken();

      var response = await apiManager
          .postData(EndPoints.addAddress, data: model.toJson(), headers: {
        "token": token,
      });
      final addressModel = AddressModel.fromJson(response.data);
      return addressModel;
    } on UnauthorizedException catch (e) {
      rethrow;
    } on ServerException catch (e) {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AddressModel> getAddresses() async {
    try {
      final token = await _getToken();

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AddressModel> deleteAddresses(String? id) async {
    try {
      final token = await _getToken();

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthModel> updateUserProfile({
    String? name,
    String? email,
    String? phone,
  }) async {
    try {

      final prefs = await SharedPrefsHelper.getInstance();
      final token = prefs.getValue<String>('token');
      final currentName = prefs.getValue<String>('name');
      final currentEmail = prefs.getValue<String>('email');
      final Map<String, dynamic> body = {};
      if (currentName != null) body['name'] = name;
      if (currentEmail != null && email != currentEmail) {
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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AuthModel> changePassword({required ChangePasswordModel model}) async {
    try {
      final token = await _getToken();
      var response = await apiManager
          .putData(EndPoints.changeMyPassword, body: model.toJson(), headers: {
        "token": token,
      });
      final authModel = AuthModel.fromJson(response.data);
      return authModel;
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
