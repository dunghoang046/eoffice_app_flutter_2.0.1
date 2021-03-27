import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LookupItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:load/load.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

bool islogin = false;
bool ischeckurl = true;
String keyword = '';
String tokenview = '';
String basemessage = '';
NguoiDungItem nguoidungsessionView = new NguoiDungItem();

checkinternet() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    return true;
  } else {
    return false;
  }
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  titleStyle: TextStyle(color: Colors.red, fontSize: 14),
);

Future<List<LookupItem>> getlookupnguoidung(
    List<NguoiDungItem> lstnguoidung) async {
  var lstitems = <LookupItem>[];
  for (var i = 0; i < lstnguoidung.length; i++) {
    var obj = new LookupItem(0, '');
    obj.id = lstnguoidung[i].id;
    obj.text = lstnguoidung[i].tenhienthi;
    lstitems.add(obj);
  }
  return lstitems;
}

TextStyle textStylelabelform = TextStyle(
    fontStyle: FontStyle.italic,
    fontSize: 13,
    fontWeight: FontWeight.bold,
    color: Colors.black);
Widget rowlabel(title) => Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 7, 0, 7),
          child: Text(title, style: textStylelabelform),
        )
      ],
    );
Widget rowlabelValidate(title) => Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 7, 0, 7),
          child: RichText(
            text: TextSpan(
                text: title,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: ' *',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
                ]),
          ),
        )
      ],
    );
Widget buildRow() => Container(
      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Image.asset("assets/images/logo.png"),
    );
const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);
const cusIcon = Icon(Icons.search, color: Colors.white);
Widget cusSearchBarr = Text('Văn bản đến');
TextStyle stylebottomnav = new TextStyle(fontSize: 13);

class StarWarsStyles {
  static final double titleFontSize = 16.0;
  static final double subTitleFontSize = 14.0;
  static final Color titleColor = Colors.black.withAlpha(220);
  static final Color subTitleColor = Colors.black87;
}

bool checkquyen(String dsQuyen, int idQuyen) {
  dsQuyen = ',' + dsQuyen + ',';
  return dsQuyen.contains(',' + idQuyen.toString() + ',');
}

Widget buildDefaultDialog() {
  return IconButton(
    icon: Icon(Icons.slideshow),
    onPressed: () {
      showLoadingDialog();
    },
  );
}

Widget loaddataerror() =>
    Center(child: SizedBox(width: 30, height: 30, child: Text('load')));
Widget on_alter(context, noidung) {
  Alert(
    context: context,
    title: "Thông báo",
    style: AlertStyle(isCloseButton: false),
    desc: noidung,
  ).show();
}
