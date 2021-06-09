import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';
import 'package:app_eoffice/views/CongViec/congviec_Formtrangthai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/views/CongViec/ThanhPhanThamGia.dart';
import 'package:app_eoffice/widget/CongViec/CongViecViewPanel.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

class MyCongViecChiTiet extends StatefulWidget {
  final int id;
  MyCongViecChiTiet({this.id});
  _MyCongViecChiTiet createState() => _MyCongViecChiTiet();
}

Future<WorkTaskItem> obj = new WorkTaskItem() as Future<WorkTaskItem>;
CongViec_Api objapi = new CongViec_Api();
TextEditingController _noidung = new TextEditingController();
TextEditingController _noidungtuchoi = new TextEditingController();
TextEditingController _noidungphathanh = new TextEditingController();
bool istrinh = false;
bool isDuyet = false;
bool isTuChoi = false;
bool isvanbandi = false;
int trangthaiid = 0;
int vitringuoikyid = 0;
bool iscapnhat = false;
List<int> lstid = <int>[];
WorkTaskItem objcv;

class _MyCongViecChiTiet extends State<MyCongViecChiTiet> {
  // ignore: must_call_super
  @override
  void initState() {
    iscapnhat = false;
    loaddata();
    _noidung.text = '';
    _noidungtuchoi.text = '';
    _noidungphathanh.text = '';
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

      objcv = await obj;
      if (objcv != null) {
        lstid = objcv.ltsUserPerform.map((value) => value.id).toList();
        if (objcv.createdUserID == nguoidungsession.id) {
          setState(() {
            iscapnhat = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chi tiết công việc',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SimpleRouter.back();
            }),
        backgroundColor: colorbartop,
      ),
      body: BlocBuilder<BlocCongViecAction, ActionState>(
          buildWhen: (previousState, state) {
        if (state is ViewState && basemessage.length > 0) {
          loaddata();
          if (basemessage != null && basemessage.length > 0) {
            Toast.show(basemessage, context,
                duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
            basemessage = '';
          }
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
            WorkTaskItem list = snapshot.data;
            return CongViecViewPanel(obj: list);
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
          if (iscapnhat && objcv.status != 3)
            SpeedDialChild(
              child: Icon(Icons.group_add, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyThanhPhanThamGia(
                  id: widget.id,
                  lstselect: lstid,
                ));
              },
              label: 'Thành phần tham gia',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (iscapnhat && objcv.status != 3)
            SpeedDialChild(
              child: Icon(Icons.ac_unit, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyThemMoiCongViec(
                  id: 0,
                  parentID: widget.id,
                ));
              },
              label: 'Giao việc tiếp',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (iscapnhat && objcv.status != 3)
            SpeedDialChild(
              child: Icon(Icons.sync, color: Colors.white),
              backgroundColor: Colors.red,
              onTap: () {
                SimpleRouter.forward(MyFormTrangThaiCongViec(
                  id: widget.id,
                ));
              },
              label: 'Trạng thái',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.red,
            ),
          if (iscapnhat && objcv.status == 3)
            SpeedDialChild(
              child: Icon(Icons.keyboard_return, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                var data = {
                  "CongViecID": widget.id,
                  "TrangThaiID": 1,
                };
                RefreshEvent addEvent = new RefreshEvent();
                addEvent.data = data;
                BlocProvider.of<BlocCongViecAction>(context).add(addEvent);
              },
              label: 'Làm lại',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
        ]);
  }
}
