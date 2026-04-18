import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/profile/data/models/address_model.dart';
import 'package:e_commerce_app/features/main/profile/domain/repositories/profile_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddAddressUseCase {
  ProfileRepo addressRepo;

  AddAddressUseCase(this.addressRepo);

  Future<Either<RouteFailures, AddressModel>> call(
          {required AddressData model}) =>
      addressRepo.addAddress(model: model);
  Future<Either<RouteFailures, AddressModel>> getAddress() =>
      addressRepo.getAddresses();
}
