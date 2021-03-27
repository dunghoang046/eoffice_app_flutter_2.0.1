import 'package:app_eoffice/models/loginItem.dart';

abstract class AuthEvent {
  LoginItem logindata;
  AuthEvent({this.logindata});
}

class LoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
