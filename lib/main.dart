import 'dart:io';

import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/NguoiDungblock.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/settingbloc.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/menu.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/CongViec/CongViec.dart';
import 'package:app_eoffice/views/DatXe/DatXe.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan.dart';
import 'package:app_eoffice/views/LichlamViec/LichlamViec.dart';
import 'package:app_eoffice/views/Nguoidung/HoSoCaNhan.dart';
import 'package:app_eoffice/views/Notification/Notification.dart';
import 'package:app_eoffice/views/Setting/Settingfingerprint.dart';
import 'package:app_eoffice/views/Thongbao/Thongbao.dart';
import 'package:app_eoffice/views/login.dart';

import 'package:flutter/material.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_VanThu.dart';
import 'package:app_eoffice/views/VanBanDi/vanbandi.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:load/load.dart';
import 'package:simple_router/simple_router.dart';
import 'package:app_eoffice/block/login_bloc/auth_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(
    LoadingProvider(
      themeData: LoadingThemeData(
          // tapDismiss: false,
          ),
      child: MyApp(),
    ),
  );
  configLoading();
}

String messageTitle = "Empty";
String notificationAlert = "alert";
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocAuth>(create: (BuildContext context) => BlocAuth()),
        BlocProvider<BlocCongViecAction>(
          create: (context) => BlocCongViecAction(),
        ),
        BlocProvider<BlocVanBanDenAction>(
          create: (context) => BlocVanBanDenAction(),
        ),
        BlocProvider<BlocVanBanDiAction>(
          create: (context) => BlocVanBanDiAction(),
        ),
        BlocProvider<BlocDuThaoVanBanAction>(
          create: (context) => BlocDuThaoVanBanAction(),
        ),
        BlocProvider<BlocSettingAction>(
          create: (context) => BlocSettingAction(),
        ),
        BlocProvider<BlocDatXeAction>(
          create: (context) => BlocDatXeAction(),
        ),
        BlocProvider<BlocNguoiDungAction>(
          create: (context) => BlocNguoiDungAction(),
        ),
      ],
      child: MaterialApp(
          color: Colors.white,
          theme: ThemeData(
              primaryColor: Colors.blue, backgroundColor: Colors.black),
          debugShowCheckedModeBanner: false,
          navigatorKey: SimpleRouter.getKey(),
          title: 'Eoffice',
          builder: EasyLoading.init(),
          home: Mymain()),
    );
  }
}

class Mymain extends StatefulWidget {
  final int datatabindex;
  @override
  Mymain({Key key, this.datatabindex}) : super(key: key);
  _MyMain createState() => _MyMain();
}

var _pageOptions = <StatefulWidget>[];
bool isFlag = false;
bool isHome = false;
String titlehead = 'Trang chủ';

class _MyMain extends State<Mymain> {
  @override
  void initState() {
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     // _showItemDialog(message);
    //   },
    //   onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     // _navigateToItemDetail(message);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     // _navigateToItemDetail(message);
    //   },
    // );
    // _pageOptions = <StatelessWidget>[];

    super.initState();
    isHome = false;
    setState(() {
      // _pageOptions = [];
      // _pageOptions.add(MyNotificationpage(globalKey: _scaffoldKey));
    });
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  void dispose() {
    super.dispose();
  }

  Widget bottomNavimain() => Container(
        color: Colors.black,
        child: BottomNavigationBar(
          currentIndex: tabIndex,
          backgroundColor: colorbar,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorhover,
          unselectedItemColor: Colors.white,
          // key: _keynavi,
          onTap: (int index) {
            setState(() {
              tabIndex = index;

              if (tabIndex == 0) {
                isHome = true;
                titlehead = 'Trang chủ';
              } else {
                if (tabIndex == 1) titlehead = 'Văn bản đến';
                if (tabIndex == 2) titlehead = 'Văn bản đi';
                isHome = false;
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                'Trang chủ',
                style: stylebottomnav,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              title: Text(
                'Văn bản đến',
                style: stylebottomnav,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.outbond),
              title: Text(
                'Văn bản đi',
                style: stylebottomnav,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text(
                'Công việc',
                style: stylebottomnav,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(
                'Dự thảo',
                style: stylebottomnav,
              ),
            ),
          ],
        ),
      );
  Widget lstmenuleft() => Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            color: Colors.white,
            child: DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Container(
                //   alignment: Alignment.center,
                //   margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                //   child: Text(
                //     'Hệ thống quản lý văn bản và điều hành',
                //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                //   ),
                // ),
                Image(image: AssetImage('assets/images/logo_login.png')),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text('Xin chào ' + nguoidungsession.tenhienthi),
                    ),
                  ),
                )
              ],
            )),
          ),
          Container(
            color: Colors.blue[50],
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.notification_important),
                  title: Text('Thông báo chung'),
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                    SimpleRouter.forward(MyThognBaopage(
                      globalKey: _scaffoldKey,
                    ));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text('Lịch làm việc'),
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                    SimpleRouter.forward(MyLichlamViecpage(
                      globalKey: _scaffoldKey,
                    ));
                  },
                ),
                if (checkquyen(
                    nguoidungsessionView.quyenhan, new QuyenHan().Vanbanden))
                  ListTile(
                    leading: Icon(Icons.verified_user),
                    title: Text('Văn bản đến'),
                    onTap: () {
                      setState(() {
                        tabIndex = 1;
                        if (_scaffoldKey.currentState.isDrawerOpen) {
                          _scaffoldKey.currentState.openEndDrawer();
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                        }
                      });
                    },
                  ),
                if (checkquyen(
                    nguoidungsessionView.quyenhan, new QuyenHan().Vanbandi))
                  ListTile(
                    leading: Icon(Icons.outbond),
                    title: Text('Văn bản đi'),
                    onTap: () {
                      setState(() {
                        tabIndex = 2;
                        if (_scaffoldKey.currentState.isDrawerOpen) {
                          _scaffoldKey.currentState.openEndDrawer();
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                        }
                      });
                    },
                  ),
                if (checkquyen(
                    nguoidungsessionView.quyenhan, new QuyenHan().Congviec))
                  ListTile(
                    leading: Icon(Icons.work),
                    title: Text('Công việc'),
                    onTap: () {
                      setState(() {
                        tabIndex = 3;
                        if (_scaffoldKey.currentState.isDrawerOpen) {
                          _scaffoldKey.currentState.openEndDrawer();
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                        }
                      });
                    },
                  ),
                if (checkquyen(nguoidungsessionView.quyenhan,
                    new QuyenHan().Thongtindatxe))
                  ListTile(
                    leading: Icon(Icons.car_rental),
                    title: Text('Thông tin đặt xe'),
                    onTap: () {
                      setState(() {
                        if (_scaffoldKey.currentState.isDrawerOpen) {
                          _scaffoldKey.currentState.openEndDrawer();
                        } else {
                          _scaffoldKey.currentState.openDrawer();
                        }
                        SimpleRouter.forward(DatXepage());
                      });
                    },
                  ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Hồ sơ cá nhân'),
                  onTap: () {
                    setState(() {
                      _scaffoldKey.currentState.openEndDrawer();
                      SimpleRouter.forward(HoSoCaNhanPage());
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Cài đặt'),
                  onTap: () {
                    setState(() {
                      _scaffoldKey.currentState.openEndDrawer();
                      SimpleRouter.forward(SettingfingerprintPage());
                    });
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Đăng xuất'),
                  onTap: () => {logout(context)},
                ),
              ],
            ),
          )
        ],
      ));
  Widget scaffold() =>
      BlocBuilder<BlocAuth, AuthState>(buildWhen: (previousState, state) {
        if (state is LogedSate) {
          if (islogin) {
            _pageOptions = [];
            _pageOptions.add(MyNotificationpage(globalKey: _scaffoldKey));
            if (widget.datatabindex != null && widget.datatabindex >= 0)
              tabIndex = widget.datatabindex;
            if (tabIndex == 0) isHome = true;
            if (islogin == false || nguoidungsessionView == null) {
            } else {
              if (!checkquyen(
                  nguoidungsessionView.quyenhan, new QuyenHan().VanthuDonvi)) {
                _pageOptions.add(MyVanBanDenpage(
                  globalKey: _scaffoldKey,
                ));
              } else {
                _pageOptions.add(MyVanBanDenVanThupage(
                  globalKey: _scaffoldKey,
                ));
              }
              _pageOptions.add(MyVanBanDipage(
                globalKey: _scaffoldKey,
              ));
              _pageOptions.add(MyCongViecpage(
                globalKey: _scaffoldKey,
              ));
              _pageOptions.add(MyDuThaoVanBanpage(
                globalKey: _scaffoldKey,
              ));
            }
          }
        }
        return;
      }, builder: (context, state) {
        if (state is LogedSate) {
          return KeyboardDismisser(
              gestures: [
                GestureType.onTap,
                GestureType.onPanUpdateDownDirection,
              ],
              child: WillPopScope(
                  child: Scaffold(
                      drawer: lstmenuleft(),
                      key: _scaffoldKey,
                      body: _pageOptions[tabIndex],
                      bottomNavigationBar: bottomNavimain()),
                  onWillPop: _onBackPressed));
        } else
          return Mylogin();
      });
  Widget build(BuildContext context) {
    return SafeArea(child: scaffold());
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => new AlertDialog(
            title: new Text('Thông báo'),
            content: new Text('Bạn có muốn đóng ứng dụng'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Text(
                    "Không",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => closeapp(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.red,
                  child: Text(
                    "Có",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void closeapp(contextdialog) {
    exit(0);
  }
}
