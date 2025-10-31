import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:e_commerce_app/features/auth/domain/use_cases/sign_up_use_cases.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SignUpUseCases signUpUseCases;
  LogInUseCase logInUseCase;
  AuthBloc(this.signUpUseCases,this.logInUseCase) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async{

      emit(state.copyWith(requestState: RequestState.loading));

      var result = await signUpUseCases.call(request: event.model);
      return result.fold((error){
        print("error response");
        emit(state.copyWith(requestState: RequestState.error,routeFailures: error));
      }, (data){
        print("Success response");
        emit(state.copyWith(requestState: RequestState.success,authModel: data));

      });
    });
    on<LogInEvent>((event, emit) async{

      emit(state.copyWith(logInRequestState: RequestState.loading));

      var result = await logInUseCase.call(event.email,event.password);
      return result.fold((error){
        print("error response");
        print(error);
        emit(state.copyWith(logInRequestState: RequestState.error,routeFailures: error));
      }, (data){
        print("Success response");
        emit(state.copyWith(logInRequestState: RequestState.success,authModel: data));

      });
    });

  }
}
