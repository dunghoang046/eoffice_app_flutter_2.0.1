import 'dart:io';

import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/menu.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/CongViec/CongViec.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan.dart';
import 'package:app_eoffice/views/LichlamViec/LichlamViec.dart';
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
    // _pageOptions = <StatelessWidget>[];
    _pageOptions.add(MyNotificationpage(globalKey: _scaffoldKey));
    super.initState();
    isHome = false;
    setState(() {});
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
              icon: Icon(Icons.settings),
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
          DrawerHeader(
            child: Text(
              '',
              style: TextStyle(color: Colors.blue[100], fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/logo_home.png'))),
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
                  leading: Icon(Icons.notification_important),
                  title: Text('Lịch làm việc'),
                  onTap: () {
                    _scaffoldKey.currentState.openEndDrawer();
                    SimpleRouter.forward(MyLichlamViecpage(
                      globalKey: _scaffoldKey,
                    ));
                  },
                ),
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
                ListTile(
                  leading: Icon(Icons.settings),
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
                ListTile(
                  leading: Icon(Icons.border_color),
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
            if (widget.datatabindex != null && widget.datatabindex >= 0)
              tabIndex = widget.datatabindex;
            if (tabIndex == 0) isHome = true;
            if (islogin == false || nguoidungsessionView == null) {
            } else {
              if (!checkquyen(nguoidungsessionView.quyenhan,
                      new QuyenHan().VanthuDonvi) &&
                  !checkquyen(nguoidungsessionView.quyenhan,
                      new QuyenHan().Vanthuphongban)) {
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
                child: Text("Không"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => closeapp(context),
                child: Text("Có"),
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
