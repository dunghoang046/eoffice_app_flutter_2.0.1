abstract class AuthState {}

class LogedSate extends AuthState {}

class LoadingState extends AuthState {}

class UnlogedState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthDoneState extends AuthState {}

class AuthLogoutSate extends AuthState {}
