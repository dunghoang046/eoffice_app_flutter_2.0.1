import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/login_bloc/Auth_event.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/settingbloc.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_router/simple_router.dart';
import 'package:custom_switch_button/custom_switch_button.dart';

class SettingfingerprintPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MySettingfingerprintPage();
  }
}

bool isSelected = false;
bool isSelectednotification = false;
SharedPreferences sharedPreferences;

class MySettingfingerprintPage extends StatefulWidget {
  @override
  _MySettingfingerprintPage createState() => _MySettingfingerprintPage();
}

class _MySettingfingerprintPage extends State<MySettingfingerprintPage> {
  @override
  void initState() {
    getselectvalue();
    super.initState();
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
    return SafeArea(
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
                    margin: EdgeInsets.fromLTRB(10, 20, 5, 0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                'Đăng nhập bằng vân tay',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                  onselect();
                                });
                              },
                              child: Center(
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
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Text(
                                'Nhận thông báo Trên Mobile',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
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
                              child: Center(
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
                      ],
                    )))));
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
