import 'package:app_eoffice/views/VanBanDen/vanbanden_TrangThaivb.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/main.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/views/VanBanDen/VanBandenguinhan/vanbanden_guinhan.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_ykien.dart';
import 'package:app_eoffice/widget/vanbanden/view_chitiet.dart';
import 'package:load/load.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
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

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Mymain(1)));
    Navigator.of(context).pop();
    print('Print chi tiết');
    return true;
  }

  bool isLoading = true;
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
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
      checktrangthaivb = vb.lstguinhan
                  .where((element) =>
                      element.nguoinhanid == nguoidungsessionView.id &&
                      element.daumoi == true)
                  .length >
              0
          ? true
          : false;
      checktrangthaicn = vb.lsttrangthai
                  .where((element) =>
                      element.nguoidungid == nguoidungsessionView.id)
                  .length >
              0
          ? true
          : false;
      var objmsg = await objapi.checktralai(dataquerycheck);
      checktralai = objmsg.error;
      setState(() {
        isLoading = false;
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MyVanBanDenGuNhan(
            //               id: widget.id,
            //             )));
            SimpleRouter.forward(MyVanBanDenGuNhan(id: widget.id));
          },
          label: 'Gửi nhận ',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.comment, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MyVanBanDenYKien(
            //               id: widget.id,
            //             )));
            SimpleRouter.forward(MyVanBanDenYKien(id: widget.id));
          },
          label: 'Ý kiến',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
        // if (checktrangthaivb)
        SpeedDialChild(
          child: Icon(Icons.done, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () {
            SimpleRouter.forward(MyTrangThaiVanBanDen(
              id: widget.id,
            ));
          },
          label: 'Trạng thái VB',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.blue,
        ),
        if (checktrangthaicn)
          SpeedDialChild(
            child: Icon(Icons.done, color: Colors.white),
            backgroundColor: Colors.blue,
            onTap: () {
              Alert(
                context: context,
                // type: AlertType.info,
                style: alertStyle,
                title: "Cập nhật trạng thái",
                // desc: "Flutter is more awesome with RFlutter Alert.",
                content: SingleChildScrollView(
                  child: Theme(
                    child: Column(
                      children: [
                        SearchableDropdown.single(
                          items: lst,
                          value: selectedValuecn,
                          hint: "Chọn trạng thái",
                          searchHint: "Chọn trạng thái",
                          onChanged: (value) {
                            setState(() {
                              selectedValuecn = value;
                            });
                          },
                          isExpanded: true,
                          // dialogBox: false,
                        ),
                        TextField(
                          maxLines: 1,
                          controller: _noidungcn,
                          decoration: InputDecoration(
                            hintText: 'Nội dung',
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide:
                                  new BorderSide(color: Colors.black, width: 5),
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
                            // labelText: widget.text_hind
                          ),
                        ),
                        NgayXuLycanhanDateField()
                      ],
                    ),
                    data: ThemeData(
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.accent),
                        accentColor: Colors.blue,
                        primaryColor: Colors.blue),
                  ),
                ),
                buttons: [
                  DialogButton(
                      onPressed: () {
                        _clicktrangthaicn();
                      },
                      width: 100,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            // size: 17,
                            color: Colors.white,
                          ),
                          Text(
                            'Cập nhật',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      )),
                  DialogButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          // size: 17,
                          color: Colors.white,
                        ),
                        Text(
                          'Hủy',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    gradient: LinearGradient(colors: [
                      Colors.red,
                      Colors.red,
                    ]),
                  )
                ],
              ).show();
            },
            label: 'Trạng thái cá nhân',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.blue,
          ),
        if (checktralai)
          SpeedDialChild(
            child: Icon(Icons.keyboard_return, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () {
              Alert(
                context: context,
                // type: AlertType.info,
                style: alertStyle,
                title: "Cập nhật trạng thái",
                // desc: "Flutter is more awesome with RFlutter Alert.",
                content: SingleChildScrollView(
                  child: Theme(
                    child: Column(
                      children: [
                        MyTextForm(noidung: _noidungtralai),
                      ],
                    ),
                    data: ThemeData(
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.accent),
                        accentColor: Colors.blue,
                        primaryColor: Colors.blue),
                  ),
                ),
                buttons: [
                  DialogButton(
                      onPressed: () {
                        _clicktralai();
                      },
                      width: 100,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.save,
                            // size: 17,
                            color: Colors.white,
                          ),
                          Text(
                            'Trả lại',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: white, fontSize: 17),
                          ),
                        ],
                      )),
                  DialogButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          // size: 17,
                          color: Colors.white,
                        ),
                        Text(
                          'Hủy',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                    onPressed: () =>
                        Navigator.of(context, rootNavigator: true).pop(),
                    gradient: LinearGradient(colors: [
                      Colors.red,
                      Colors.red,
                    ]),
                  )
                ],
              ).show();
            },
            label: 'Trả lại',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            labelBackgroundColor: Colors.deepOrange,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    return Scaffold(
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
        backgroundColor: Color.fromARGB(255, 248, 144, 31),
      ),
      body: contentbody(dataquery),
      floatingActionButton: buildSpeedDial(),
    );
  }

  // ignore: unused_element
  void _clickketthuc() {
    showLoadingDialog();
    Vanbanden_api vbdenapi = new Vanbanden_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidung.text,
      "TrangThaiID": selectedValue,
      "HanXuLy": _hanxuly.text
    };
    vbdenapi.postketthuc(data).then((objdata) {
      hideLoadingDialog();
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyVanVanDenChiTiet(id: widget.id)),
        );
      }
    });
  }

  void _clicktralai() {
    showLoadingDialog();
    Vanbanden_api vbdenapi = new Vanbanden_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidungtralai.text,
    };

    vbdenapi.posttralai(data).then((objdata) {
      hideLoadingDialog();
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }

  void _clicktrangthaicn() {
    showLoadingDialog();
    Vanbanden_api vbdenapi = new Vanbanden_api();
    var data = {
      "VanBanID": widget.id,
      "NoiDung": _noidungcn.text,
      "TrangThaiID": selectedValue,
      "HanXuLy": _hanxulycn.text
    };
    vbdenapi.postketthuc(data).then((objdata) {
      hideLoadingDialog();
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            // toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
  }
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
