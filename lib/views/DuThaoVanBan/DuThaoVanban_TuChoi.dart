import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

class MyDuThaoVanBanTuCHoi extends StatefulWidget {
  final int id;
  MyDuThaoVanBanTuCHoi({@required this.id});

  @override
  _MyDuThaoVanBanTuCHoi createState() => new _MyDuThaoVanBanTuCHoi();
}

Future<LanhDaoTrinhDTItem> objlanhdaotrinh;
DuThaoVanBan_api objapi = new DuThaoVanBan_api();
TextEditingController _noidung = new TextEditingController();
TextEditingController _ngaytrinhky = new TextEditingController();

class _MyDuThaoVanBanTuCHoi extends State<MyDuThaoVanBanTuCHoi> {
  // ignore: must_call_super
  void initState() {
    loaddata();
    _noidung.text = '';
  }

  void loaddata() async {
    var dataquery = {"VanBanID": '' + widget.id.toString() + ''};
    if (widget.id != null && widget.id > 0) {
      objlanhdaotrinh = objapi.getlanhdaotrinh(dataquery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            backgroundColor: Colors.grey[350],
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Trình lãnh đạo',
                style: TextStyle(color: Colors.white),
              ),
              leading: new IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    SimpleRouter.back();
                  }),
              actions: [_onLoginClick()],
              backgroundColor: colorbartop,
            ),
            body: SingleChildScrollView(
                child: BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
                    buildWhen: (previousState, state) {
              if (state is ViewState) {
                Toast.show(basemessage, context,
                    duration: 2,
                    gravity: Toast.TOP,
                    backgroundColor: Colors.green);
                BlocProvider.of<BlocDuThaoVanBanAction>(context)
                    .add(ListEvent());
                SimpleRouter.back();
              }
              if (state is ErrorState) {
                Toast.show(basemessage, context,
                    duration: 2,
                    gravity: Toast.TOP,
                    backgroundColor: Colors.red);
              }
              return;
            }, builder: (context, state) {
              return Theme(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 8.0),
                        spreadRadius: 5,
                        blurRadius: 7,
                        // offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  // color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Form(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyTextForm(
                        text_hind: 'Nội dung',
                        noidung: _noidung,
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                              child: MaterialButton(
                                  // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  onPressed: () {
                                    SimpleRouter.back();
                                  },
                                  color: Colors.red,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Hủy',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: white),
                                      ),
                                    ],
                                  ))),
                        ],
                      )
                    ],
                  )),
                ),
                data: ThemeData(
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.accent),
                    accentColor: Colors.blue,
                    primaryColor: Colors.blue),
              );
            }))));
  }

  Widget _onLoginClick() {
    return BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
        builder: (context, state) {
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
          icons: Icons.save,
          label: 'Từ chối',
          mOnPressed: () => {_clicktrinhld()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Từ chối',
          mOnPressed: () => _clicktrinhld(),
        );
        // }
      }
    });
  }

  void _clicktrinhld() {
    if ((_noidung == null || (_noidung.text.length <= 0))) {
      Toast.show('Bạn chưa nhập nội dung ', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
    } else {
      var data = {
        "VanBanID": widget.id,
        "NoiDung": _noidung,
      };
      TuChoiEvent yKienEvent = new TuChoiEvent();
      yKienEvent.data = data;
      BlocProvider.of<BlocDuThaoVanBanAction>(context).add(yKienEvent);
    }
  }
}
