part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetData extends ProfileEvent {}

class AddAddress extends ProfileEvent {
  AddressData model;

  AddAddress(this.model);
}

class DeleteAddressEvent extends ProfileEvent {
  final String id;

  DeleteAddressEvent({required this.id});
}
class UpdatePhoneNumberEvent extends ProfileEvent {
  final String phone;
  UpdatePhoneNumberEvent(this.phone);
}
class GetAddresses extends ProfileEvent {}
