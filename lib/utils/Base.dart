import 'package:app_eoffice/views/PDFScreen.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LookupItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:load/load.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:simple_router/simple_router.dart';
import 'package:url_launcher/url_launcher.dart';

bool islogin = false;
bool ischeckurl = true;
String keyword = '';
String tokenview = '';
String basemessage = '';
// dynamic lstfile;
int tabIndex = 0;
bool isautologin = true;
bool isSelectedremember = false;
NguoiDungItem nguoidungsessionView = new NguoiDungItem();
String strurlviewfile = "http://hpu2.e-office.vn/";
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
Future<void> loadding() async {
  await EasyLoading.show(
    status: 'Đang xử lý...',
    maskType: EasyLoadingMaskType.custom,
  );
}

Future<void> dismiss() async {
  await EasyLoading.dismiss();
}

Widget containerRowViewfile(String value, int id, String filelink) => Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black26,
          ),
          // right: BorderSide(color: Colors.green, width: 6),
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: RichText(
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: value, style: TextStyle(color: Colors.black))
                  ])),
              onTap: () async {
                if (filelink.contains('.pdf') || filelink.contains('.PDF')) {
                  var urlfile = strurlviewfile + filelink;
                  SimpleRouter.forward(MyPDFSceen(pathfile: urlfile));
                } else {
                  var urlfile =
                      strurlviewfile + "view_file.aspx?FileID=" + id.toString();
                  _launchURL(urlfile);
                }
              },
            ),
          )
        ],
      ),
    );
void _launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
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
