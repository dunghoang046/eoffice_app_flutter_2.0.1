import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/models/DanhMucXeItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/DatXe_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

List<DropdownMenuItem> lst = [];
Future<List<NguoiDungItem>> lstlaixe;
Future<List<DanhMucXeItem>> lstxe;
String laixeid;
String xeid;
DatXe_Api objApi = new DatXe_Api();
int selectedValue;
TextEditingController _lydo = new TextEditingController();

class MyFormReject extends StatefulWidget {
  final id;
  MyFormReject({this.id});
  _MyFormReject createState() => _MyFormReject();
}

class _MyFormReject extends State<MyFormReject> {
  @override
  void initState() {
    selectedValue = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<BlocDatXeAction, ActionState>(
            buildWhen: (previousState, state) {
      if (state is DoneState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
        SimpleRouter.back();
      }
      if (state is ErrorState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
      }
      return;
    }, builder: (context, state) {
      return SafeArea(
          child: KeyboardDismisser(
              child: Container(
                  child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Từ chối',
            style: TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                SimpleRouter.back();
              }),
          backgroundColor: colorbartop,
          actions: <Widget>[_onLoginClick1()],
        ),
        body: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          child: MyTextForm(
            text_hind: 'Lý do',
            noidung: _lydo,
            isvalidate: true,
          ),
        )),
      ))));
    }));
  }

  Widget _onLoginClick1() {
    // ignore: missing_return
    return BlocBuilder<BlocDatXeAction, ActionState>(builder: (context, state) {
      if (state is LoadingState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          label: 'Đang xử lý ...',
          mOnPressed: () => {},
        );
      } else if (state is ErrorState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.approval,
          label: 'Từ chối',
          mOnPressed: () => {_click_add()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.approval,
          label: 'Từ chối',
          mOnPressed: () => _click_add(),
        );
        // }
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _click_add() {
    if (_lydo.text != null &&
        _lydo.text != "" &&
        _lydo.text != null &&
        _lydo.text != "") {
      var data = {
        "DatXeID": widget.id,
        "LyDo": _lydo.text,
      };
      RejectEvent addEvent = new RejectEvent();
      addEvent.data = data;
      BlocProvider.of<BlocDatXeAction>(context).add(addEvent);
    } else
      Toast.show('Bạn chưa nhập lý do', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}
