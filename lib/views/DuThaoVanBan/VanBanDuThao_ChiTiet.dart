import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_Duyet.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_GuiNhan.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_Phathanh.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_TrangThai.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanban_TuChoi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/Base.dart';

import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBanTrinh.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBanYKien.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanViewPanel.dart';
import 'package:simple_router/simple_router.dart';

class MyDuThaoVanBanChiTiet extends StatefulWidget {
  final int id;
  MyDuThaoVanBanChiTiet({@required this.id});
  _MyDuThaoVanBanChiTiet createState() => _MyDuThaoVanBanChiTiet();
}

Future<DuThaoVanBanItem> obj;
DuThaoVanBanItem objvb = new DuThaoVanBanItem();
DuThaoVanBan_api objapi = new DuThaoVanBan_api();
TextEditingController _noidung = new TextEditingController();
TextEditingController _noidungtuchoi = new TextEditingController();
TextEditingController _noidungphathanh = new TextEditingController();
bool istrinh = false;
bool isDuyet = false;
bool isTuChoi = false;
bool isvanbandi = false;
bool ishoanthanh = false;
int trangthaiid = 0;
int vitringuoikyid = 0;

class _MyDuThaoVanBanChiTiet extends State<MyDuThaoVanBanChiTiet> {
  // ignore: must_call_super
  void initState() {
    loaddata();
    _noidung.text = '';
    _noidungtuchoi.text = '';
    _noidungphathanh.text = '';
  }

  bool isLoading = true;
  void dispose() {
    super.dispose();
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      obj = objapi.getbyId(dataquery);
      objvb = await obj;
      if (objvb != null && objvb.id > 0) {
        setState(() {
          istrinh = objvb.isTrinh;
          isDuyet = objvb.isDuyet;
          isTuChoi = objvb.isTuChoi;
          isvanbandi = objvb.isvanbandi;
          trangthaiid = objvb.trangthaiid;
          vitringuoikyid = objvb.vitringuoikyid;
          ishoanthanh = objvb.ishoanthanh;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chi tiết dự thảo',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SimpleRouter.back();
            }),
        backgroundColor: colorbartop,
      ),
      // body: contentbody(dataquery),
      body: BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
        buildWhen: (previousState, state) {
          if (state is ViewState) {
            loaddata();
          }
          return;
        },
        builder: (context, state) {
          return contentbody(dataquery);
        },
      ),
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
            DuThaoVanBanItem list = snapshot.data;
            return ViewDuThaoVanBanPanel(obj: list);
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
          if (istrinh)
            SpeedDialChild(
              child: Icon(Icons.send, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyDuThaoVanBanTrinh(
                  id: widget.id,
                ));
              },
              label: 'Trình lãnh đạo',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (isDuyet)
            SpeedDialChild(
              child: Icon(Icons.arrow_drop_up, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyDuThaoVanBanDuyet(
                  id: widget.id,
                ));
              },
              label: 'Duyệt',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (isTuChoi)
            SpeedDialChild(
              child: Icon(Icons.arrow_back, color: Colors.white),
              backgroundColor: Colors.red,
              onTap: () {
                SimpleRouter.forward(MyDuThaoVanBanTuCHoi(
                  id: widget.id,
                ));
              },
              label: 'Từ chối',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.red,
            ),
          // if ((trangthaiid != 5 &&
          //         trangthaiid != 2 &&
          //         trangthaiid != 6 &&
          //         isvanbandi!=true &&
          //         (!isvanbandi || (isvanbandi && trangthaiid == 4))) &&
          //     (trangthaiid == 3 &&
          //         checkquyen(
          //             nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi)))
          if (trangthaiid == 3 &&
              !checkquyen(nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
            SpeedDialChild(
              child: Icon(Icons.bookmark, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyDuThaoVanBanPhatHanh(
                  id: widget.id,
                ));
              },
              label: 'Chuyển phát hành',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          if (ishoanthanh)
            SpeedDialChild(
              child: Icon(Icons.done, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                SimpleRouter.forward(MyDuThaoTrangThai(id: widget.id));
              },
              label: 'Cập nhật trạng thái',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.blue,
            ),
          SpeedDialChild(
            child: Icon(Icons.comment, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              SimpleRouter.forward(MyDuThaoVanBanYKien(id: widget.id));
            },
            label: 'Ý kiến',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.blue,
          ),
          SpeedDialChild(
            child: Icon(Icons.sync, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              SimpleRouter.forward(MyDuThaoVanBanGuiNhan(id: widget.id));
            },
            label: 'Gửi nhận',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.blue,
          ),
        ]);
  }
}
