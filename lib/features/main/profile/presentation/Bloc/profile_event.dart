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
  String? name;
  String? email;
  String? phone;

  UpdateUserProfileEvent({this.name, this.phone, this.email});
}

class GetAddresses extends ProfileEvent {}

class ChangePasswordEvent extends ProfileEvent {
  ChangePasswordModel model;

  ChangePasswordEvent({required this.model});
}

class LogoutEvent extends ProfileEvent {}
