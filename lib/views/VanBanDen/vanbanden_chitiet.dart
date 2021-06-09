import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_TraLai.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_TrangThaivb.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_trangthaicn.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/VanBanDen/VanBandenguinhan/vanbanden_guinhan.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_ykien.dart';
import 'package:app_eoffice/widget/vanbanden/view_chitiet.dart';
import 'package:intl/intl.dart';
import 'package:simple_router/simple_router.dart';

class VanBanDenChiTiet extends StatelessWidget {
  final int id;
  VanBanDenChiTiet({@required this.id});
  @override
  Widget build(BuildContext context) {
    return MyVanVanDenChiTiet(
      id: id,
    );
  }
}

int selectedValue;
int selectedValuecn;

class MyVanVanDenChiTiet extends StatefulWidget {
  final int id;
  MyVanVanDenChiTiet({@required this.id});
  _MyVanVanDenChiTiet createState() => _MyVanVanDenChiTiet();
}

String error = '';
List<DropdownMenuItem> lst = [];
TextEditingController _noidung = new TextEditingController();
TextEditingController _noidungcn = new TextEditingController();
TextEditingController _hanxuly = new TextEditingController();
TextEditingController _hanxulycn = new TextEditingController();
TextEditingController _noidungtralai = new TextEditingController();

class _MyVanVanDenChiTiet extends State<MyVanVanDenChiTiet> {
  Future<VanBanDenItem> obj;
  bool checktralai = false;
  bool checktrangthaicn = false;
  bool checktrangthaivb = false;
  Vanbanden_api objapi = new Vanbanden_api();

  @override
  void initState() {
    loaddata();
    _noidung.text = '';
    _noidungtralai.text = '';
    lst.add(DropdownMenuItem(
      child: Text("Chưa xử lý"),
      value: 0,
    ));
    lst.add(DropdownMenuItem(
      child: Text("Đang xử lý"),
      value: 1,
    ));
    lst.add(DropdownMenuItem(
      child: Text("Đã xử lý"),
      value: 3,
    ));
    // BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      obj = objapi.getbyId(dataquery);
      var vb = await obj;

      var dataquerycheck = {
        "ID": '' + widget.id.toString() + '',
        "VanBanDiID": '' + vb.vanbandiid.toString() + '',
        "VanBanDenID": '' + vb.vanbandenid.toString() + ''
      };
      var objmsg = await objapi.checktralai(dataquerycheck);
      setState(() {
        checktrangthaivb = vb.lstguinhan
                    .where((element) =>
                        element.nguoinhanid == nguoidungsessionView.id &&
                        element.daumoi == true)
                    .length >
                0
            ? true
            : false;
        checktrangthaicn = (vb.lsttrangthai
                        .where((element) =>
                            element.nguoidungid == nguoidungsessionView.id)
                        .length >
                    0 &&
                !checkquyen(
                    nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) &&
                !checkquyen(nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
            ? true
            : false;
        checktralai = objmsg.error;
      });
    }
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
            VanBanDenItem list = snapshot.data;
            return ViewVanBanPanel(obj: list);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
  bool dialVisible = true;

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: dialVisible,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.sync, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () {
            SimpleRouter.forward(MyVanBanDenGuNhan(id: widget.id));
          },
          label: 'Gửi nhận ',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.comment, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () {
            SimpleRouter.forward(MyVanBanDenYKien(id: widget.id));
          },
          label: 'Ý kiến',
          labelStyle:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          labelBackgroundColor: Colors.green,
        ),
        if (checktrangthaivb)
          SpeedDialChild(
            child: Icon(Icons.done, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              SimpleRouter.forward(MyTrangThaiVanBanDen(
                id: widget.id,
              ));
            },
            label: 'Trạng thái VB',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.blue,
          ),
        if (checktrangthaicn)
          SpeedDialChild(
            child: Icon(Icons.done, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              SimpleRouter.forward(MyTrangThaiVanBanDenCaNhan(
                id: widget.id,
              ));
            },
            label: 'Trạng thái cá nhân',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.blue,
          ),
        if (checktralai)
          SpeedDialChild(
            child: Icon(Icons.keyboard_return, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () {
              SimpleRouter.forward(MyTraLaiVanBanDen(
                id: widget.id,
              ));
            },
            label: 'Trả lại',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.deepOrange,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chi tiết văn bản đến',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => SimpleRouter.back(),
        ),
        backgroundColor: colorbartop,
      ),
      body: BlocBuilder<BlocVanBanDenAction, ActionState>(
        buildWhen: (previousState, state) {
          if (state is ViewState) {
            loaddata();
          }
          return;
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: contentbody(dataquery),
          );
        },
      ),
      floatingActionButton: buildSpeedDial(),
    ));
  }

  // ignore: unused_element
}

class NgayXuLyDateField extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _hanxuly,
        decoration: InputDecoration(
          hintText: "Ngày xử lý",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(color: Colors.black, width: 5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey[200],
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.grey[200],
            ),
          ),
          // labelText: 'Hạn xử lý'
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
            // confirmText: 'Chọn',
            // cancelText: 'Hủy'
          );
        },
      ),
    ]);
  }
}

class NgayXuLycanhanDateField extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _hanxulycn,
        decoration: InputDecoration(
          hintText: "Ngày xử lý",
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(color: Colors.black, width: 5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey[200],
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.grey[200],
            ),
          ),
          // labelText: 'Hạn xử lý'
        ),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
            // confirmText: 'Chọn',
            // cancelText: 'Hủy'
          );
        },
      ),
    ]);
  }
}
