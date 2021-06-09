import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocNguoiDungAction extends Bloc<ActionEvent, ActionState> {
  BlocNguoiDungAction() : super(DoneState());
  get initialState => DoneState();

  bool isError = false;
  NguoiDung_Api objapi = new NguoiDung_Api();

  Base_service base_service = new Base_service();
  static get loginItem => loginItem;

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      isError = false;
      bool _isLogedswith;
      yield LoadingState();
      if (event is LoginSwitchEvent) {
        await base_service.getloginswitchdonvi(event.data).then((result) {
          nguoidungsession = result;
          if (nguoidungsession != null) {
            token = nguoidungsession.token;
            nguoidungsessionView = nguoidungsession;
            tokenview = token;
            _isLogedswith = true;
          } else {}
        });

        if (_isLogedswith)
          yield DoneState();
        else {
          ischeckurl = false;
          yield ErrorState();
        }
      }
      if (event is LoginSwitchPBEvent) {
        await base_service.getloginswitchphongban(event.data).then((result) {
          if (result != null) {
            nguoidungsession = result;
            if (nguoidungsession != null) {
              token = nguoidungsession.token;
              nguoidungsessionView = nguoidungsession;
              tokenview = token;
              _isLogedswith = true;
            } else {}
          }
        });

        if (_isLogedswith)
          yield DoneState();
        else {
          ischeckurl = false;
          yield ErrorState();
        }
      }
      if (event is ListEvent) {
        yield ViewState();
      }
    } catch (ex) {
      yield ErrorState();
    }
  }
}
