import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';

enum RequestState { init, loading, error, success }

class ProfileState {
  AuthModel? authModel;
  AddressModel? addressModel;

  final bool isLoggedOut;

  RequestState? getDataRequestState;
  RequestState? addAddressRequestState;
  RequestState? getAddressRequestState;
  RequestState? deleteAddressRequestState;
  RequestState? updateProfileRequestState;
  RequestState? changePasswordRequestState;

  RouteFailures? changePasswordFailures;
  RouteFailures? updateProfileFailures;
  RouteFailures? routeFailures;
  RouteFailures? addAddressFailures;
  RouteFailures? getAddressFailures;
  RouteFailures? deleteAddressFailures;

  ProfileState(
      {this.routeFailures,
      this.getDataRequestState,
      this.authModel,
      this.isLoggedOut = false,
      this.addressModel,
      this.changePasswordFailures,
      this.changePasswordRequestState,
      this.updateProfileRequestState,
      this.updateProfileFailures,
      this.getAddressRequestState,
      this.getAddressFailures,
      this.deleteAddressRequestState,
      this.deleteAddressFailures,
      this.addAddressRequestState,
      this.addAddressFailures});

  ProfileState copyWith({
    AuthModel? authModel,
    bool? isLoggedOut,
    AddressModel? addressModel,
    RequestState? getAddressRequestState,
    RouteFailures? getAddressFailures,
    RequestState? changePasswordRequestState,
    RouteFailures? changePasswordFailures,
    RequestState? addAddressRequestState,
    RequestState? deleteAddressRequestState,
    RouteFailures? addAddressFailures,
    RouteFailures? deleteAddressFailures,
    RouteFailures? routeFailures,
    RouteFailures? updateProfileFailures,
    RequestState? getDataRequestState,
    RequestState? updateProfileRequestState,
  }) {
    return ProfileState(
        isLoggedOut: isLoggedOut ?? this.isLoggedOut,
        changePasswordFailures:
            changePasswordFailures ?? this.changePasswordFailures,
        changePasswordRequestState:
            changePasswordRequestState ?? this.changePasswordRequestState,
        getAddressFailures: getAddressFailures ?? this.getAddressFailures,
        updateProfileRequestState:
            updateProfileRequestState ?? this.updateProfileRequestState,
        updateProfileFailures:
            updateProfileFailures ?? this.updateProfileFailures,
        deleteAddressFailures:
            deleteAddressFailures ?? this.deleteAddressFailures,
        deleteAddressRequestState:
            deleteAddressRequestState ?? this.deleteAddressRequestState,
        getAddressRequestState:
            getAddressRequestState ?? this.getAddressRequestState,
        addressModel: addressModel ?? this.addressModel,
        addAddressFailures: addAddressFailures ?? this.addAddressFailures,
        getDataRequestState: getDataRequestState ?? this.getDataRequestState,
        routeFailures: routeFailures ?? this.routeFailures,
        addAddressRequestState:
            addAddressRequestState ?? this.addAddressRequestState,
        authModel: authModel ?? this.authModel);
  }
}

final class ProfileInitial extends ProfileState {
  ProfileInitial()
      : super(
          getDataRequestState: RequestState.init,
          isLoggedOut: false,
        );
}
