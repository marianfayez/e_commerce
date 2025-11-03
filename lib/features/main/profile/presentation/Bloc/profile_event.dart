part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class GetData extends ProfileEvent{

}

class AddAddress extends ProfileEvent{
  String name;
  String details;
  String phone;
  String city;
  AddAddress(this.name,this.details,this.phone,this.city);
}

class GetAddresses  extends ProfileEvent{

}
