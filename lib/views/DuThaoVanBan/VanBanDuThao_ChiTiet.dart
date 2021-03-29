import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/main.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBanTrinh.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBanYKien.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanViewPanel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:load/load.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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
        istrinh = objvb.isTrinh;
        isDuyet = objvb.isDuyet;
        isTuChoi = objvb.isTuChoi;
        isvanbandi = objvb.isvanbandi;
        trangthaiid = objvb.trangthaiid;
        vitringuoikyid = objvb.vitringuoikyid;
      }
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
          'Chi tiết dự thảo',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SimpleRouter.back();
            }),
        backgroundColor: Color.fromARGB(255, 248, 144, 31),
      ),
      body: contentbody(dataquery),
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
          if ((istrinh &&
                  !nguoidungsessionView.tennhomnguoidung.contains('HĐTV')) ||
              (isDuyet &&
                  (nguoidungsessionView.vitriid == 4 ||
                      (nguoidungsessionView.vitriid == 3 &&
                          !nguoidungsessionView.tennhomnguoidung
                              .contains('HĐTV')))))
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
          if (isDuyet && nguoidungsessionView.vitriid != 4)
            SpeedDialChild(
              child: Icon(Icons.arrow_drop_up, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                Alert(
                  context: context,
                  // type: AlertType.info,
                  style: alertStyle,
                  title: "Duyệt",
                  // desc: "Flutter is more awesome with RFlutter Alert.",
                  content: SingleChildScrollView(
                    child: Theme(
                      child: Column(
                        children: [
                          MyTextForm(noidung: _noidung),
                        ],
                      ),
                      data: ThemeData(
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.accent),
                          accentColor: Colors.blue,
                          primaryColor: Colors.blue),
                    ),
                  ),
                  buttons: [
                    DialogButton(
                        onPressed: () {
                          _clickapproved();
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
                              'Đồng ý',
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
                Alert(
                  context: context,
                  // type: AlertType.info,
                  style: alertStyle,
                  title: "Từ chối",
                  // desc: "Flutter is more awesome with RFlutter Alert.",
                  content: SingleChildScrollView(
                    child: Theme(
                      child: Column(
                        children: [
                          MyTextForm(noidung: _noidungtuchoi),
                        ],
                      ),
                      data: ThemeData(
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.accent),
                          accentColor: Colors.blue,
                          primaryColor: Colors.blue),
                    ),
                  ),
                  buttons: [
                    DialogButton(
                        onPressed: () {
                          _clickreject();
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
                              'Đồng ý',
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
              label: 'Từ chối',
              labelStyle:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              labelBackgroundColor: Colors.red,
            ),
          if ((trangthaiid != 5 &&
                  trangthaiid != 2 &&
                  trangthaiid != 6 &&
                  (!isvanbandi | (isvanbandi && trangthaiid == 4))) &&
              (nguoidungsessionView.vitriid != 3 &&
                  trangthaiid == 3 &&
                  vitringuoikyid == 3))
            SpeedDialChild(
              child: Icon(Icons.bookmark, color: Colors.white),
              backgroundColor: Colors.blue,
              onTap: () {
                Alert(
                  context: context,
                  // type: AlertType.info,
                  style: alertStyle,
                  title: "Phát hành",
                  // desc: "Flutter is more awesome with RFlutter Alert.",
                  content: SingleChildScrollView(
                    child: Theme(
                      child: Column(
                        children: [
                          MyTextForm(noidung: _noidungphathanh),
                        ],
                      ),
                      data: ThemeData(
                          buttonTheme: ButtonThemeData(
                              textTheme: ButtonTextTheme.accent),
                          accentColor: Colors.blue,
                          primaryColor: Colors.blue),
                    ),
                  ),
                  buttons: [
                    DialogButton(
                        onPressed: () {
                          _clickdistribute();
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
                              'Đồng ý',
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
              label: 'Chuyển phát hành',
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
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pop();
      }
    });
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
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context, rootNavigator: true).pop();
      }
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
      if (objdata["Error"] == true)
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            // timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        Fluttertoast.showToast(
            msg: objdata["Title"],
            toastLength: Toast.LENGTH_SHORT,
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
