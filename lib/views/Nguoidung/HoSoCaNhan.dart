import 'dart:ui';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/NguoiDung/NguoiDungViewPanel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_router/simple_router.dart';

class HoSoCaNhanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHoSoCaNhanPage();
  }
}

bool isSelected = false;
bool isSelectednotification = false;
SharedPreferences sharedPreferences;
Future<NguoiDungItem> objnd;
NguoiDung_Api objApi = new NguoiDung_Api();

class MyHoSoCaNhanPage extends StatefulWidget {
  @override
  _MyHoSoCaNhanPage createState() => _MyHoSoCaNhanPage();
}

class _MyHoSoCaNhanPage extends State<MyHoSoCaNhanPage> {
  @override
  void initState() {
    getselectvalue();
    loaddata();
    super.initState();
  }

  void loaddata() async {
    var dataquery = {"ID": '' + nguoidungsession.id.toString() + ''};
    setState(() {
      objnd = objApi.getnguoidungbyid(dataquery);
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Hồ sơ cá nhân'),
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
                    child: Column(
              children: [
                Card(
                    color: Colors.white,

                    // margin: EdgeInsets.all(5),
                    child: SizedBox(
                      height: 465,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   color: Colors.lightBlue[800],
                          //   child: ListTile(
                          //     leading: Icon(
                          //       Icons.person,
                          //       color: Colors.white,
                          //     ),
                          //     title: Text(
                          //       'Thông tin cá nhân',
                          //       style: TextStyle(
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.bold),
                          //     ),
                          //     // subtitle: Text('Thông tin'),
                          //   ),
                          // ),
                          FutureBuilder(
                            future: objnd,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text('Đã có lỗi xảy ra'),
                                );
                              }
                              if (snapshot.hasData) {
                                NguoiDungItem list = snapshot.data;
                                return NguoiDungViewPanel(obj: list);
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    )),
              ],
            )))));
  }
}
