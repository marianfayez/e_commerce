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
class UpdateUserProfileEvent extends ProfileEvent {
  final User user;
  UpdateUserProfileEvent(this.user);
}
class GetAddresses extends ProfileEvent {}
