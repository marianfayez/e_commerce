part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent{
  SignUpRequestModel model;
  SignUpEvent(this.model);
}
class LogInEvent extends AuthEvent{
  String email;
  String password;
  LogInEvent(this.email,this.password);
}