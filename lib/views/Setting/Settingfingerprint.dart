import 'dart:ui';
import 'package:app_eoffice/block/NguoiDungblock.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/settingbloc.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

class SettingfingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MySettingfingerprintPage();
  }
}

bool isSelected = false;
bool isSelectednotification = false;
SharedPreferences sharedPreferences;
Future<NguoiDungItem> objnd;
List<DropdownMenuItem> lstdv = [];
List<DropdownMenuItem> lstpb = [];
String donviselectid;
String phongbanselectid;
bool isloadding = false;
NguoiDung_Api objApi = new NguoiDung_Api();

class MySettingfingerprintPage extends StatefulWidget {
  @override
  _MySettingfingerprintPage createState() => _MySettingfingerprintPage();
}

class _MySettingfingerprintPage extends State<MySettingfingerprintPage> {
  @override
  void initState() {
    getselectvalue();
    loaddata();
    super.initState();
  }

  void loaddata() async {
    lstdv = [];
    lstpb = [];
    var dataquery = {"ID": '' + nguoidungsession.id.toString() + ''};
    donviselectid = nguoidungsession.donviid.toString();
    phongbanselectid = nguoidungsession.ltsphongbanid[0].toString();
    setState(() {
      objnd = objApi.getnguoidungbyid(dataquery);
      if (nguoidungsession.lstdonvicuanguoidung.length > 1)
        for (var i = 0; i < nguoidungsession.lstdonvicuanguoidung.length; i++) {
          lstdv.add(DropdownMenuItem(
            child: Text(nguoidungsession.lstdonvicuanguoidung[i].ten),
            value: nguoidungsession.lstdonvicuanguoidung[i].id.toString(),
          ));
        }

      if (nguoidungsession.lstphongban.length > 1)
        for (var i = 0; i < nguoidungsession.lstphongban.length; i++) {
          lstpb.add(DropdownMenuItem(
            child: Text(nguoidungsession.lstphongban[i].ten),
            value: nguoidungsession.lstphongban[i].id.toString(),
          ));
        }
    });
  }

  void getselectvalue() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("isFingerprint") != null)
      isSelected = sharedPreferences.getBool("isFingerprint");
    if (sharedPreferences.getBool("isNotification") != null)
      isSelectednotification = sharedPreferences.getBool("isNotification");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<BlocNguoiDungAction, ActionState>(
            buildWhen: (previousState, state) {
      if (state is DoneState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
        loaddata();
      }
      if (state is ErrorState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
      }
      return;
    }, builder: (context, state) {
      return KeyboardDismisser(
          child: SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    title: Text('Cài đặt'),
                    actions: [],
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          SimpleRouter.back();
                        }),
                    backgroundColor: colorbartop,
                  ),
                  body: SingleChildScrollView(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.fingerprint,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
                                    child: Text(
                                      'Đăng nhập bằng vân tay',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected = !isSelected;
                                        onselect();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.bottomRight,
                                      margin: EdgeInsets.fromLTRB(66, 0, 0, 0),
                                      height: 16,
                                      width: 40,
                                      child: CustomSwitchButton(
                                        backgroundColor: Colors.blueGrey,
                                        unCheckedColor: Colors.white,
                                        animationDuration:
                                            Duration(milliseconds: 400),
                                        checkedColor: Colors.lightGreen,
                                        checked: isSelected,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.notification_important,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 5, 10, 0),
                                    child: Text(
                                      'Nhận thông báo Trên Mobile',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelectednotification =
                                            !isSelectednotification;
                                        onselectNoti();
                                      });
                                    },
                                    child: Container(
                                      height: 16,
                                      width: 40,
                                      margin: EdgeInsets.fromLTRB(40, 0, 0, 0),
                                      child: CustomSwitchButton(
                                        backgroundColor: Colors.blueGrey,
                                        unCheckedColor: Colors.white,
                                        animationDuration:
                                            Duration(milliseconds: 400),
                                        checkedColor: Colors.lightGreen,
                                        checked: isSelectednotification,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (nguoidungsession.lstdonvicuanguoidung.length >
                                  1)
                                // Icon(
                                //   Icons.ac_unit,
                                //   size: 20,
                                //   color: Colors.blue,
                                // ),
                                Container(
                                  // height: 60,
                                  child: SearchableDropdown.single(
                                    iconSize: 15,
                                    underline: Container(
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.teal,
                                                  width: 2.0))),
                                    ),
                                    displayItem: (item, selected) {
                                      return (Row(children: [
                                        selected
                                            ? Icon(
                                                Icons.radio_button_checked,
                                                color: Colors.grey,
                                              )
                                            : Icon(
                                                Icons.radio_button_unchecked,
                                                color: Colors.grey,
                                              ),
                                        SizedBox(width: 7),
                                        Expanded(
                                          child: item,
                                        ),
                                      ]));
                                    },

                                    isCaseSensitiveSearch: false,
                                    items: lstdv,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    value: donviselectid,
                                    hint: "Chọn đơn vị",
                                    searchHint: null,
                                    onChanged: (value) {
                                      setState(() {
                                        donviselectid = value;
                                        var data = {
                                          "userName": '' +
                                              nguoidungsession.tentruycap +
                                              '',
                                          "DonViID": '' + donviselectid + ''
                                        };
                                        LoginSwitchEvent loginevent =
                                            new LoginSwitchEvent();
                                        loginevent.data = data;

                                        BlocProvider.of<BlocNguoiDungAction>(
                                                context)
                                            .add(loginevent);
                                      });
                                    },
                                    displayClearIcon: false,
                                    dialogBox: false,
                                    isExpanded: true,
                                    // icon: Icon(Icons.ac_unit),
                                    menuConstraints: BoxConstraints.tight(
                                        Size.fromHeight(250)),
                                  ),
                                ),
                              if (lstpb.length > 1)
                                Container(
                                  // height: 100,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: SearchableDropdown.single(
                                    iconSize: 15,
                                    underline: Container(
                                      height: 1.0,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.teal,
                                                  width: 2.0))),
                                    ),

                                    items: lstpb,
                                    // readOnly: true,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    displayClearIcon: false,
                                    value: phongbanselectid,
                                    hint: "Chọn phòng ban",
                                    isCaseSensitiveSearch: false,
                                    searchHint: null,
                                    onChanged: (value) {
                                      setState(() {
                                        phongbanselectid = value;
                                        var data = {
                                          "userName": '' +
                                              nguoidungsession.tentruycap +
                                              '',
                                          "PhongBanID":
                                              '' + phongbanselectid + ''
                                        };
                                        LoginSwitchPBEvent loginevent =
                                            new LoginSwitchPBEvent();
                                        loginevent.data = data;
                                        BlocProvider.of<BlocNguoiDungAction>(
                                                context)
                                            .add(loginevent);
                                      });
                                    },
                                    dialogBox: false,
                                    isExpanded: true,
                                    menuConstraints: BoxConstraints.tight(
                                        Size.fromHeight(250)),
                                  ),
                                ),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ))))));
    }));
  }

  void onselect() async {
    sharedPreferences.setBool("isFingerprint", isSelected);
  }

  void onselectNoti() async {
    sharedPreferences.setBool("isNotification", isSelectednotification);
    var strtoken = await FirebaseMessaging().getToken();
    SettingNhanNotificationEvent settingnotificationEvent =
        new SettingNhanNotificationEvent();
    var objdata = {
      'NguoiDungID': nguoidungsessionView.id,
      'IsNotification': isSelectednotification,
      'Token': strtoken
    };
    settingnotificationEvent.data = objdata;
    BlocProvider.of<BlocSettingAction>(context).add(settingnotificationEvent);
  }
}
