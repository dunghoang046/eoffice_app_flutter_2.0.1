import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LookupItem.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_ykien.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/ComBo_DonViPhoiHop.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/Combo_lanhdaotrinh.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_lanhdaobutphe.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_nguoiXuLy.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_nguoiphoihop.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combox_DonviDauMoi.dart';
import 'package:intl/intl.dart';
import 'package:load/load.dart';
import 'package:toast/toast.dart';
import 'package:simple_router/simple_router.dart';

class MyVanBanDenYKienForm extends StatefulWidget {
  final int id;
  MyVanBanDenYKienForm({@required this.id});

  @override
  _MyVanBanDenYKienForm createState() => new _MyVanBanDenYKienForm();
}

NguoiDung_Api nndApi = new NguoiDung_Api();
DonVi_Api dvApi = new DonVi_Api();
Future<List<LookupItem>> lstlanhdao;
TextEditingController _hanxuly = new TextEditingController();
TextEditingController _noidung = new TextEditingController();
var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};

class _MyVanBanDenYKienForm extends State<MyVanBanDenYKienForm> {
  void initState() {
    super.initState();
    loaddata();
  }

  void loaddata() async {
    var lstnguoidung = await nndApi.getnguoidungbychucvu(dataquery);
    lstlanhdao = getlookupnguoidung(lstnguoidung);
  }

  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Ý kiến văn bản đến',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.pop(context);
              SimpleRouter.back();
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
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 2)
                    rowlabel('Trình lãnh đạo'),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 2)
                    MyComBo_Lanhdaotrinh(),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 2)
                    rowlabel('Lãnh đạo bút phê'),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 2)
                    // MyComBo_sign(
                    //   lstlookup: lstlanhdao,
                    //   text_hint: 'Chọn lãnh đạo bút phê',
                    // ),
                    MyComBo_Lanhdaobutphe(),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 3 ||
                      nguoidungsession.vitriid == 2)
                    rowlabel('Đơn vị đầu mối'),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 3 ||
                      nguoidungsession.vitriid == 2)
                    MyComBo_DonViDauMoi(),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 3 ||
                      nguoidungsession.vitriid == 2)
                    rowlabel('Đơn vị phối hợp'),
                  if (checkquyen(
                          nguoidungsession.quyenhan, QuyenHan().VanthuDonvi) ||
                      nguoidungsession.vitriid == 3 ||
                      nguoidungsession.vitriid == 2)
                    MyComBo_DonViPhoiHop(),
                  if (nguoidungsession.vitriid != 5 &&
                      nguoidungsession.vitriid != 2)
                    rowlabel('Người xử lý'),
                  if (nguoidungsession.vitriid != 5 &&
                      nguoidungsession.vitriid != 2)
                    MyComBo_NguoiXuLy(),
                  if (nguoidungsession.vitriid != 5 &&
                      nguoidungsession.vitriid != 2)
                    rowlabel('Người phối hợp'),
                  if (nguoidungsession.vitriid != 5 &&
                      nguoidungsession.vitriid != 2)
                    MyComBo_NguoiphoiHop(),
                  rowlabel('Nội dung'),
                  MyTextForm(
                    text_hind: 'Nội dung',
                    noidung: _noidung,
                  ),
                  rowlabel('Hạn xử lý'),
                  BasicDateField(),
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
                                    'Lưu và gửi',
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
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
            accentColor: Colors.blue,
            primaryColor: Colors.blue),
      )),
    ));
  }

  void _clickykien() {
    showLoadingDialog();
    Vanbanden_api vbdenapi = new Vanbanden_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidung.text,
      "LtsTrinhLanhDao": lstlanhdaotrinh,
      "LtsLanhDao": ltsLanhDao,
      "LstDonViDauMoi": lstDonViDauMoi,
      "LstDonViPhoiHop": lstDonViPhoiHop,
      "LstNguoiDauMoi": lstNguoiDauMoi,
      "LstNguoiPhoiHop": lstNguoiPhoiHop,
      "HanXuLy": _hanxuly.text
    };
    vbdenapi.postykien(data).then((objdata) {
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

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _hanxuly,
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
