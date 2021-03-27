import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';
import 'package:app_eoffice/views/CongViec/congviec_Formtrangthai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/views/CongViec/ThanhPhanThamGia.dart';
import 'package:app_eoffice/widget/CongViec/CongViecViewPanel.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:load/load.dart';
import 'package:simple_router/simple_router.dart';

class MyCongViecChiTiet extends StatefulWidget {
  final int id;
  MyCongViecChiTiet({this.id});
  _MyCongViecChiTiet createState() => _MyCongViecChiTiet();
}

Future<WorkTaskItem> obj = new WorkTaskItem() as Future<WorkTaskItem>;
WorkTaskItem objvb = new WorkTaskItem();
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
List<int> lstid = <int>[];
WorkTaskItem objcv;

class _MyCongViecChiTiet extends State<MyCongViecChiTiet> {
  // ignore: must_call_super
  @override
  void initState() {
    loaddata();
    _noidung.text = '';
    _noidungtuchoi.text = '';
    _noidungphathanh.text = '';
  }

  bool isLoading = true;
  @override
  void dispose() {
    print('Đóng chi tiết cv');
    super.dispose();
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      obj = objapi.getbyId(dataquery);
      objvb = await obj;
      if (objcv != null)
        lstid = objcv.ltsUserPerform.map((value) => value.id).toList();
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    return Scaffold(
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
        backgroundColor: Color.fromARGB(255, 248, 144, 31),
      ),
      body: BlocBuilder<BlocCongViecAction, ActionState>(
          buildWhen: (previousState, state) {
        if (state is ViewState) {
          loaddata();
        }
        return;
      }, builder: (context, state) {
        return contentbody(dataquery);
      }),
      floatingActionButton: buildSpeedDial(),
    );
  }

  Widget contentbody(dataquery) => Center(
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
        ]);
  }

// action duyệt
  void _clickapproved() {
    showLoadingDialog();
    DuThaoVanBan_api objapi = new DuThaoVanBan_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidung.text,
    };

    objapi.postapproved(data).then((objdata) {
      hideLoadingDialog();
      // if (objdata["Error"] == true)
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // else {
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   Navigator.of(context, rootNavigator: true).pop();
      // }
    });
  }

  void _clickfinsh() {
    FinshEvent finshEvent = new FinshEvent();
    finshEvent.data = null;
    BlocProvider.of<BlocCongViecAction>(context).add(finshEvent);
  }

  void _clickreject() {
    showLoadingDialog();
    DuThaoVanBan_api objapi = new DuThaoVanBan_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidungtuchoi.text,
    };

    objapi.postreject(data).then((objdata) {
      hideLoadingDialog();
      // if (objdata["Error"] == true)
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // else {
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   Navigator.of(context, rootNavigator: true).pop();
      // }
    });
  }

  void _clickdistribute() {
    showLoadingDialog();
    DuThaoVanBan_api objapi = new DuThaoVanBan_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidungphathanh.text,
      "PhamViID": '2',
    };

    objapi.postreject(data).then((objdata) {
      hideLoadingDialog();
      // if (objdata["Error"] == true)
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.red,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      // else {
      //   Fluttertoast.showToast(
      //       msg: objdata["Title"],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.TOP,
      //       // timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.green,
      //       textColor: Colors.white,
      //       fontSize: 16.0);
      //   Navigator.of(context, rootNavigator: true).pop();
      // }
    });
  }
}
