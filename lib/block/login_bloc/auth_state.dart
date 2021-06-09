abstract class AuthState {}

class LogedSate extends AuthState {}

class AuLoadingState extends AuthState {}

class UnlogedState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthDoneState extends AuthState {}

class AuthLogoutSate extends AuthState {}

class AuthSwitchSate extends AuthState {}

class AuthSettingNotificationState extends AuthState {}
