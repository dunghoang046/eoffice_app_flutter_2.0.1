import 'package:flutter/material.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_ykien.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_Nguoidung.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_donvi.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_nhomDonVi.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_nhomNguoiDung.dart';
import 'package:load/load.dart';
import 'package:toast/toast.dart';

class MyVanBanDiGuiNhanForm extends StatefulWidget {
  final int id;
  MyVanBanDiGuiNhanForm({@required this.id});

  @override
  _MyVanBanDiGuiNhan createState() => new _MyVanBanDiGuiNhan();
}

class _MyVanBanDiGuiNhan extends State<MyVanBanDiGuiNhanForm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
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
                    Navigator.pop(context);
                  }),
              backgroundColor: Color.fromARGB(255, 248, 144, 31),
            ),
            body: SingleChildScrollView(
                child: Theme(
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
                            margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                onPressed: () {
                                  _clickykien();
                                },
                                color: Colors.blue,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.save,
                                      size: 17,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'Phát hành',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: white),
                                    ),
                                  ],
                                ))),
                        Container(
                            margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                            child: MaterialButton(
                                // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MyVanBanDenYKien(id: widget.id)),
                                  );
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
            ))));
  }

  void _clickykien() {
    showLoadingDialog();
    Vanbandi_api vbapi = new Vanbandi_api();
    var data = {
      "VanBanID": widget.id,
      "Lstdonvi": lstdonvi,
      "Lstnguoidung": lstnguoidung,
      "Lstnhomdonvi": lstnhomdonvi,
      "Lstnhomnguoidung": lstnhomnguoidung,
    };
    vbapi.postchuyenvanban(data).then((objdata) {
      hideLoadingDialog();
      if (objdata["Error"] == true)
        Toast.show(objdata["Title"], context,
            duration: Toast.LENGTH_SHORT,
            gravity: Toast.TOP,
            backgroundColor: Colors.red);
      else {
        Toast.show(objdata["Title"], context,
            duration: 3, gravity: Toast.TOP, backgroundColor: Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyVanBanDenYKien(id: widget.id)),
        );
      }
    });
  }
}
