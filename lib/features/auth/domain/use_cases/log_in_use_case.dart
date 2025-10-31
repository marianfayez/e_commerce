import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogInUseCase {

  AuthRepo authRepo;

  LogInUseCase(this.authRepo);

  Future<Either<RouteFailures,AuthModel>>call(String email,String password)=>authRepo.logIn(email: email, password: password);
}