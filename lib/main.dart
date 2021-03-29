import 'dart:io';

import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/views/CongViec/CongViec.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan.dart';
import 'package:app_eoffice/views/Notification/Notification.dart';
import 'package:app_eoffice/views/login.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_VanThu.dart';
import 'package:app_eoffice/views/VanBanDi/vanbandi.dart';
import 'package:load/load.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';
import 'package:app_eoffice/block/login_bloc/auth_state.dart';

void main() => runApp(
      LoadingProvider(
        themeData: LoadingThemeData(
            // tapDismiss: false,
            ),
        child: MyApp(),
      ),
    );
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      ],
      child: MaterialApp(
          color: Colors.white,
          theme: ThemeData(
              primaryColor: Colors.blue, backgroundColor: Colors.black),
          debugShowCheckedModeBanner: false,
          navigatorKey: SimpleRouter.getKey(),
          title: 'Eoffice',
          home: Mylogin()),
    );
  }
}

Widget scaffoldloading() => Scaffold(
      body: Mylogin(),
    );

class Mymain extends StatefulWidget {
  final int datatabindex;
  @override
  Mymain({Key key, this.datatabindex}) : super(key: key);
  _MyMain createState() => _MyMain();
}

var _pageOptions = <StatelessWidget>[];
bool isFlag = false;
bool isHome = false;
int tabIndex = 0;
String titlehead = 'Trang chủ';

class _MyMain extends State<Mymain> {
  @override
  void initState() {
    _pageOptions = <StatelessWidget>[];
    _pageOptions.add(Notificationpage());
    super.initState();
    isHome = false;
    setState(() {
      if (widget.datatabindex >= 0) tabIndex = widget.datatabindex;
      if (tabIndex == 0) isHome = true;
      if (islogin == false || nguoidungsessionView == null) {
      } else {
        if (!checkquyen(
                nguoidungsessionView.quyenhan, new QuyenHan().VanthuDonvi) &&
            !checkquyen(
                nguoidungsessionView.quyenhan, new QuyenHan().Vanthuphongban)) {
          _pageOptions.add(VanBanDenpage());
        } else {
          _pageOptions.add(VanBanDenVanThupage());
        }
        _pageOptions.add(VanBanDipage());
        _pageOptions.add(CongViecpage());
        _pageOptions.add(DuThaoVanBanpage());
      }
    });
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
  Widget scaffold() =>
      BlocBuilder<BlocAuth, AuthState>(buildWhen: (previousState, state) {
        if (state is AuthErrorState) {
          Toast.show(basemessage, context,
              duration: 3, gravity: Toast.TOP, backgroundColor: Colors.red);
        }
        if (state is AuthLogoutSate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Mylogin()));
        }
        return;
      }, builder: (context, state) {
        return WillPopScope(
            child: Scaffold(
                key: _scaffoldKey,
                body: _pageOptions[tabIndex],
                bottomNavigationBar: bottomNavimain()),
            onWillPop: _onBackPressed);
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
