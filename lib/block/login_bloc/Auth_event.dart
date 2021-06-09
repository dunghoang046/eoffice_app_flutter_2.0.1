abstract class AuthEvent {
  // LoginItem logindata;
  dynamic logindata;
  AuthEvent({this.logindata});
}

class LoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
