import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';

enum RequestState { init, loading, error, success }

class ProfileState {
  AuthModel? authModel;
  AddressModel? addressModel;
  RequestState? getDataRequestState;
  RequestState? addAddressRequestState;
  RequestState? getAddressRequestState;

  RouteFailures? routeFailures;
  RouteFailures? addAddressFailures;
  RouteFailures? getAddressFailures;

  ProfileState(
      {this.routeFailures,
      this.getDataRequestState,
      this.authModel,
      this.addressModel,
      this.getAddressRequestState,
      this.getAddressFailures,
      this.addAddressRequestState,
      this.addAddressFailures});

  ProfileState copyWith({
    AuthModel? authModel,
    AddressModel? addressModel,
    RequestState? getAddressRequestState,
    RouteFailures? getAddressFailures,
    RequestState? addAddressRequestState,
    RouteFailures? addAddressFailures,
    RouteFailures? routeFailures,
    RequestState? getDataRequestState,
  }) {
    return ProfileState(
        getAddressFailures: getAddressFailures ?? this.getAddressFailures,
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
            addAddressRequestState: RequestState.init,
            getAddressRequestState: RequestState.init);
}
