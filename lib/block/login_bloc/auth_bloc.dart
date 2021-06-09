import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/login_bloc/Auth_event.dart';
import 'package:app_eoffice/block/login_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/Base.dart';

class BlocAuth extends Bloc<AuthEvent, AuthState> {
  BlocAuth() : super(AuthLogoutSate());
  get initialState => AuthLogoutSate();
  final Base_service base_service = new Base_service();

  static get loginItem => loginItem;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    try {
      bool _isLoged = false;
      var isErrorsetting = false;
      if (event is LoginEvent) {
        yield AuLoadingState();
        var data = {
          "userName": event.logindata.userName,
          "password": event.logindata.password,
          "lang": "vi",
          "checkFingerprint": "true"
        };
        await base_service.getlogin(data).then((result) {
          nguoidungsession = result;
          if (nguoidungsession != null) {
            islogin = true;
            token = nguoidungsession.token;
            nguoidungsessionView = nguoidungsession;
            tokenview = token;
            _isLoged = true;
            ischeckurl = true;
          } else {}
        });

        if (_isLoged)
          yield LogedSate();
        else {
          ischeckurl = false;
          yield AuthErrorState();
        }
      }

      if (event is LogoutEvent) {
        nguoidungsessionView = null;
        tokenview = null;
        _isLoged = false;
        yield AuthLogoutSate();
      }
    } catch (e) {}
  }
}
