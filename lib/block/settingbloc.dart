import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocSettingAction extends Bloc<ActionEvent, ActionState> {
  BlocSettingAction() : super(DoneState());

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    Base_service objapi = new Base_service();
    // TODO: implement mapEventToState
    try {
      bool isError = false;
      if (event is SettingNhanNotificationEvent) {
        yield LoadingState();
        await objapi.postcauhinhnhannotification(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
        ;
      }
      if (event is NoEven) yield NoState();
    } catch (ex) {}
  }
}
