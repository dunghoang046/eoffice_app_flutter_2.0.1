import 'package:app_eoffice/models/loginItem.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/services/local_auth_api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_eoffice/widget/FormLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/login_bloc/Auth_event.dart';
import 'package:app_eoffice/block/login_bloc/auth_state.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

SharedPreferences sharedPreferences;

class Mylogin extends StatefulWidget {
  // final int state;
  // Mylogin({this.state});
  _Mylogin createState() => _Mylogin();
}

bool isFlag = false;
String messageTitle = '';
FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _Mylogin extends State<Mylogin> {
  @override
  void initState() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text('Thông báo'),
        //         content: Text('Kích vào thông báo onMessage: $message'),
        //       );
        //     });
        // _showItemDialog(message);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text('Thông báo'),
        //         content: Text('Kích vào thông báo onLaunch: $message'),
        //       );
        //     });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Thông báo'),
                content: Text('Kích vào thông báo onResume: $message'),
              );
            });
      },
    );
    // _sharedPreferences();
    isSelectedremember = false;
    BlocProvider.of<BlocAuth>(context).add(LogoutEvent());
    loadlogin();

    super.initState();
  }

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      // ignore: unused_local_variable
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  }

  loadlogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences != null &&
        sharedPreferences.getBool("isSelectedremember") != null)
      isSelectedremember = sharedPreferences.getBool("isSelectedremember");
    if (isSelectedremember == true && isautologin) {
      LoginItem objlogin = new LoginItem();
      objlogin.checkFingerprint = "true";
      objlogin.lang = "vi";
      objlogin.userName = sharedPreferences.getString("username");
      objlogin.password = sharedPreferences.getString("password");

      LoginEvent loginevent = new LoginEvent();
      loginevent.logindata = objlogin;
      // ignore: await_only_futures
      BlocProvider.of<BlocAuth>(context).add(loginevent);
    }
  }

  // ignore: must_call_super
  void _radio() {
    setState(() {
      isSelectedremember = !isSelectedremember;
      sharedPreferences.setBool("isSelectedremember", isSelectedremember);
    });
  }

  @override
  void dispose() {
    print('dispose: đóng');
    _usernameController.text = '';
    _passwordController.text = '';
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    //this method not called when user press android back button or quit
    print('deactivate');
  }

  final _formKey = GlobalKey<FormState>();
  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );
  @override
  Widget build(BuildContext context) {
    return _FormLogin();
  }

  Widget _FormLogin() {
    return BlocBuilder<BlocAuth, AuthState>(
      buildWhen: (previousState, state) {
        if (state is AuLoadingState) {
          loadding();
        }
        if (state is AuthErrorState && basemessage.length > 0) {
          dismiss();
          Toast.show(basemessage, context,
              duration: 3, gravity: Toast.TOP, backgroundColor: Colors.red);
          basemessage = '';
        }
        if (state is LogedSate) {
          // var nguoidung = nguoidungsessionView.toJson().toString();
          // sharedPreferences.setString('nguoidungsession', '$nguoidung');

          dismiss();
        }
        return;
      },
      builder: (context, state) {
        return ScreenUtilInit(
            builder: () => KeyboardDismisser(
                    child: SafeArea(
                        child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  // key: _scaffoldKey,
                  backgroundColor: Colors.white,
                  body: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Center(
                              child: Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: Image.asset(
                              "assets/images/logo_login.png",
                              width: ScreenUtil().setWidth(270),
                              height: ScreenUtil().setHeight(100),
                            ),
                          )),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Image.asset("assets/images/eoffice.png"),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          Expanded(
                              child: Image.asset("assets/images/image_02.png"))
                        ],
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 28.0, right: 28.0, top: 230.0),
                          child: Column(
                            children: <Widget>[
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      MyFormLogin(
                                        pass: _passwordController,
                                        username: _usernameController,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              GestureDetector(
                                                onTap: _radio,
                                                child: radioButton(
                                                    isSelectedremember),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              InkWell(
                                                child: Text("Ghi nhớ đăng nhập",
                                                    style: TextStyle(
                                                        fontSize: 12)),
                                              )
                                            ],
                                          ),
                                          _onLoginClick1()
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(20),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await _checksettingFingerprint();
                                        },
                                        child: Icon(
                                          Icons.fingerprint,
                                          color: Colors.blue,
                                          size: 70,
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(300),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
      },
    );
  }

  Future<bool> _checksettingFingerprint() async {
    try {
      var isvalue = false;
      if (sharedPreferences.getBool("isFingerprint") != null)
        isvalue = sharedPreferences.getBool("isFingerprint");
      if (!isvalue || isvalue == null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Thông báo'),
                content: Text('Bạn chưa cài đặt đăng nhập bằng vân tay'),
              );
            });
      } else {
        final isAuthenticated = await LocalAuthApi.authenticate();
        if (isAuthenticated) {
          LoginItem objlogin = new LoginItem();
          objlogin.checkFingerprint = "true";
          objlogin.lang = "vi";
          objlogin.userName = sharedPreferences.getString("username");
          objlogin.password = sharedPreferences.getString("password");
          LoginEvent loginevent = new LoginEvent();
          loginevent.logindata = objlogin;
          if (objlogin.userName == null || objlogin.password == null) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Thông báo'),
                    content: Text('Thông tin chưa được thiết lập'),
                  );
                });
          } else
            BlocProvider.of<BlocAuth>(context).add(loginevent);
        }
      }
    } catch (ex) {
      return true;
    }
    return true;
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      String _username = _usernameController.text;
      String _password = _passwordController.text;

      sharedPreferences.setString("password", _passwordController.text);
      if ((_username == null || (_username != null && _username.length <= 0)) &&
          sharedPreferences.getString("username") != null) {
        _username = sharedPreferences.getString("username");
        sharedPreferences.setString("username", _username);
      } else
        sharedPreferences.setString("username", _usernameController.text);
      sharedPreferences.setBool("isSelectedremember", isSelectedremember);

      LoginItem objlogin = new LoginItem();
      objlogin.checkFingerprint = "true";
      objlogin.lang = "vi";
      objlogin.userName = _username;
      objlogin.password = _password;
      LoginEvent loginevent = new LoginEvent();
      loginevent.logindata = objlogin;
      // ignore: await_only_futures
      BlocProvider.of<BlocAuth>(context).add(loginevent);
    }
  }

  Widget _onLoginClick1() {
    // ignore: missing_return
    return BlocBuilder<BlocAuth, AuthState>(builder: (context, state) {
      if (state is AuLoadingState) {
        return ButtonLogin(
          isLoading: true,
          backgroundColor: Colors.white,
          label: 'Đang xử lý ...',
          mOnPressed: () => {},
        );
      } else if (state is LogedSate) {
        return ButtonLogin(
          // backgroundColor: Colors.white,
          label: 'Thành công!',
          mOnPressed: () => _login(),
        );
      } else if (state is AuthErrorState) {
        return ButtonLogin(
          // backgroundColor: Colors.white,
          labelColor: Colors.white,
          label: 'Đăng nhập',
          mOnPressed: () => {_login()},
        );
      } else {
        return ButtonLogin(
          // backgroundColor: Colors.white,
          labelColor: Colors.white,
          label: 'Đăng nhập',
          mOnPressed: () => _login(),
        );
      }
    });
  }
}

// ignore: non_constant_identifier_names
final Base_service base_service = new Base_service();
