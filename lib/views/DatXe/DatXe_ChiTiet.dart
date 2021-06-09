import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/ThongTinDatXeItem.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/DatXe_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/DatXe/DatXe_GuiNhan.dart';
import 'package:app_eoffice/views/DatXe/Reject.dart';
import 'package:app_eoffice/views/DatXe/pFormApproved.dart';
import 'package:app_eoffice/widget/DatXe/DatXeViewPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

class MyDatXeChiTiet extends StatefulWidget {
  final int id;
  MyDatXeChiTiet({this.id});
  _MyDatXeChiTiet createState() => _MyDatXeChiTiet();
}

Future<ThongTinDatXeItem> obj =
    new ThongTinDatXeItem() as Future<ThongTinDatXeItem>;
ThongTinDatXeItem objvb = new ThongTinDatXeItem();
DatXe_Api objapi = new DatXe_Api();
bool issend = false;
bool isDuyet = false;
bool isTuChoi = false;
bool isvanbandi = false;
ThongTinDatXeItem objcv;

class _MyDatXeChiTiet extends State<MyDatXeChiTiet> {
  // ignore: must_call_super
  @override
  void initState() {
    issend = false;
    isTuChoi = false;
    isDuyet = false;
    loaddata();
  }

  @override
  void dispose() {
    print('Đóng chi tiết cv');
    super.dispose();
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      obj = objapi.getbyId(dataquery);
      var objdx = await obj;
      setState(() {
        if (objdx.nguoitaoid == nguoidungsession.id &&
            (objdx.trangthaiid == 4 || objdx.trangthaiid == 2)) {
          issend = true;
        }
        if (objdx.trangthaiid != 3 &&
            checkquyen(nguoidungsessionView.quyenhan,
                new QuyenHan().Duyetthongtindatxe)) isDuyet = true;
        if (checkquyen(
            nguoidungsessionView.quyenhan, new QuyenHan().Duyetthongtindatxe))
          isTuChoi = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Thông tin đặt xe',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SimpleRouter.back();
            }),
        backgroundColor: colorbartop,
      ),
      body: BlocBuilder<BlocDatXeAction, ActionState>(
          buildWhen: (previousState, state) {
        if (state is DoneState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
          loaddata();
        }
        if (state is ErrorState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
        }
        return;
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: contentbody(),
        );
      }),
      floatingActionButton: buildSpeedDial(),
    ));
  }

  Widget contentbody() => Center(
          child: FutureBuilder(
        future: obj,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            ThongTinDatXeItem list = snapshot.data;
            return DatXeViewPanel(obj: list);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
  SpeedDial buildSpeedDial() {
    return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        onOpen: () => print('Mở'),
        onClose: () => print('Đóng'),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.record_voice_over, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              SimpleRouter.forward(MyDatXeGuiNhan(
                id: widget.id,
              ));
            },
            label: 'Gửi nhận',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.blue,
          ),
          if (issend == true)
            SpeedDialChild(
              child: Icon(Icons.send, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                var dataquery = {"DatXeID": '' + widget.id.toString() + ''};
                SendEvent addEvent = new SendEvent();
                addEvent.data = dataquery;
                BlocProvider.of<BlocDatXeAction>(context).add(addEvent);
              },
              label: 'Gửi đặt xe',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (isDuyet == true)
            SpeedDialChild(
              child: Icon(Icons.approval, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyFormApproved(
                  id: widget.id,
                ));
              },
              label: 'Duyệt',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (isTuChoi == true)
            SpeedDialChild(
              child: Icon(Icons.cancel, color: Colors.white),
              backgroundColor: Colors.red,
              onTap: () {
                SimpleRouter.forward(MyFormReject(
                  id: widget.id,
                ));
              },
              label: 'Từ chối',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.red,
            ),
        ]);
  }
}
