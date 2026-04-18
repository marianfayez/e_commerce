import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/data/models/auth_model.dart';
import 'package:e_commerce_app/features/main/profile/data/models/changePassword.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordUseCase {

  ProfileRepo profileRepo;

  ChangePasswordUseCase(this.profileRepo);

  Future<Either<RouteFailures,AuthModel>>call(ChangePasswordModel model)=>profileRepo.changePassword(model);


}