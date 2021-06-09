import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_Nguoidung.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_donvi.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_nhomDonVi.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_nhomNguoiDung.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

class MyVanBanDiGuiNhanForm extends StatefulWidget {
  final int id;
  MyVanBanDiGuiNhanForm({@required this.id});

  @override
  _MyVanBanDiGuiNhan createState() => new _MyVanBanDiGuiNhan();
}

class _MyVanBanDiGuiNhan extends State<MyVanBanDiGuiNhanForm> {
  @override
  void initState() {
    BlocProvider.of<BlocVanBanDiAction>(context).add(NoEven());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Scaffold(
                backgroundColor: Colors.grey[350],
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'Gửi nhận',
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
                    child: BlocBuilder<BlocVanBanDiAction, ActionState>(
                        buildWhen: (previousState, state) {
                  if (state is ViewState) {
                    Toast.show(basemessage, context,
                        duration: 2,
                        gravity: Toast.TOP,
                        backgroundColor: Colors.green);
                    BlocProvider.of<BlocVanBanDiAction>(context)
                        .add(ViewYKienEvent());
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
                          rowlabel('Nơi nhận'),
                          MyComBo_Donvi(),
                          rowlabel('Người nhận'),
                          MyComBo_NguoiDung(),
                          rowlabel('Nhóm đơn vị'),
                          MyComBo_NhomDonVi(),
                          rowlabel('Nhóm người dùng'),
                          MyComBo_NhomNguoiDung(),
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
                })))));
  }

  Widget _onLoginClick() {
    return BlocBuilder<BlocVanBanDiAction, ActionState>(
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
          label: 'Phát hành',
          mOnPressed: () => {_clickykien()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Phát hành',
          mOnPressed: () => _clickykien(),
        );
        // }
      }
    });
  }

  void _clickykien() {
    if ((lstdonvi == null || lstdonvi != null && lstdonvi.length <= 0) &&
        (lstnguoidung == null ||
            lstdonvi != null && lstnguoidung.length <= 0) &&
        (lstnhomdonvi == null ||
            lstdonvi != null && lstnhomdonvi.length <= 0) &&
        (lstnhomnguoidung == null ||
            lstdonvi != null && lstnhomnguoidung.length <= 0)) {
      Toast.show('Bạn chưa nhập thông tin ', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
    } else {
      var data = {
        "VanBanID": widget.id,
        "Lstdonvi": lstdonvi,
        "Lstnguoidung": lstnguoidung,
        "Lstnhomdonvi": lstnhomdonvi,
        "Lstnhomnguoidung": lstnhomnguoidung,
      };
      ChuyenVanBanEvent yKienEvent = new ChuyenVanBanEvent();
      yKienEvent.data = data;
      BlocProvider.of<BlocVanBanDiAction>(context).add(yKienEvent);
    }
  }
}
