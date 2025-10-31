part of 'auth_bloc.dart';

enum RequestState{init,loading,error,success}

 class AuthState {

AuthModel? authModel;
RequestState? requestState;
RequestState? logInRequestState;
RouteFailures? routeFailures;

AuthState({this.routeFailures,this.requestState,this.logInRequestState,this.authModel});

AuthState copyWith({AuthModel? authModel,
RequestState? requestState,
RouteFailures? routeFailures,
  RequestState? logInRequestState,
}){

  return AuthState(requestState: requestState ?? this.requestState,
      logInRequestState: logInRequestState ?? this.logInRequestState,
  routeFailures: routeFailures ?? this.routeFailures,
  authModel: authModel ?? this.authModel);
}
 }

final class AuthInitial extends AuthState {
  AuthInitial():super(requestState: RequestState.init,logInRequestState: RequestState.init);
}
