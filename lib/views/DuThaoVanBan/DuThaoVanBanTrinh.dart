import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/ComBo_LanhDaoTrinh.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/Combo_LanhDaoLienQuan.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/Combo_PhongBanLienQuan.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/Combo_canbolienquan.dart';
import 'package:load/load.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class MyDuThaoVanBanTrinh extends StatefulWidget {
  final int id;
  MyDuThaoVanBanTrinh({@required this.id});

  @override
  _MyDuThaoVanBanTrinh createState() => new _MyDuThaoVanBanTrinh();
}

Future<LanhDaoTrinhDTItem> objlanhdaotrinh;
DuThaoVanBan_api objapi = new DuThaoVanBan_api();
TextEditingController _noidung = new TextEditingController();
TextEditingController _ngaytrinhky = new TextEditingController();

class _MyDuThaoVanBanTrinh extends State<MyDuThaoVanBanTrinh> {
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
    // TODO: implement build
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
                    rowlabel('Ngày trình ký'),
                    NgayTrinhKy(),
                    rowlabelValidate('Lãnh đạo phê duyệt'),
                    MyComBo_LanhdaoTrinhDT(
                      lstnguoidung: objlanhdaotrinh,
                    ),
                    rowlabel('Lãnh đạo liên quan'),
                    MyComBo_LanhdaoLienQuan(lstnguoidung: objlanhdaotrinh),
                    rowlabel('Phòng ban liên quan'),
                    MyComBo_PhongBanLienQuan(),
                    rowlabel('Cán bộ liên quan'),
                    MyComBo_CanBoLienQuan(),
                    rowlabel('Nội dung'),
                    MyTextForm(
                      text_hind: 'Nội dung',
                      noidung: _noidung,
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                            child: MaterialButton(
                                padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                onPressed: () {
                                  _clicktrinhld();
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
                                            MyDuThaoVanBanChiTiet(
                                                id: widget.id)),
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

  void _clicktrinhld() {
    showLoadingDialog();
    DuThaoVanBan_api vbapi = new DuThaoVanBan_api();
    var data = {
      "VanBanID": widget.id,
      "NguoiKyID": lanhdaotrinhid,
      "LanhDaoLienQuan": lstlanhdaolienquan,
      "PhongBanDonViLienQuan": lstphongbanlienquan,
      "CanBoLienQuan": lstcanbolienquan,
      "NoiDung": _noidung,
      "NgayTrinhKy": _ngaytrinhky,
    };
    vbapi.posttrinhky(data).then((objdata) {
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
              builder: (context) => MyDuThaoVanBanChiTiet(id: widget.id)),
        );
      }
    });
  }
}

class NgayTrinhKy extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _ngaytrinhky,
        decoration: InputDecoration(
          // hintText: "Nội dung",
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
          // labelText: 'Nội dung'
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
