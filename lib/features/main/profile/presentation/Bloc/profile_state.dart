import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';

enum RequestState{init,loading,error,success}

class ProfileState {

  AuthModel? authModel;
  RequestState? getDataRequestState;
  RouteFailures? routeFailures;

  ProfileState({this.routeFailures,this.getDataRequestState,this.authModel});

  ProfileState copyWith({AuthModel? authModel,
    RouteFailures? routeFailures,
    RequestState? getDataRequestState,
  }){

    return ProfileState(
        getDataRequestState: getDataRequestState ?? this.getDataRequestState,
        routeFailures: routeFailures ?? this.routeFailures,
        authModel: authModel ?? this.authModel);
  }
}

final class ProfileInitial extends ProfileState {
  ProfileInitial():super(getDataRequestState: RequestState.init);
}
