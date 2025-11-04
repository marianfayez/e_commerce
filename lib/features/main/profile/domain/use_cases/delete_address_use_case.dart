import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAddressUseCase {
  ProfileRepo addressRepo;

  DeleteAddressUseCase(this.addressRepo);


  Future<Either<RouteFailures, AddressModel>> deleteAddress(String id) =>
      addressRepo.deleteAddress( id);

}
