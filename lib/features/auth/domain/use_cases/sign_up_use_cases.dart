import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/data/models/sign_up_request_model.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCases {

  AuthRepo authRepo;

  SignUpUseCases( this.authRepo);

  Future <Either<RouteFailures,AuthModel>>call({required SignUpRequestModel request}){

    return authRepo.signUp(request: request);

  }
}