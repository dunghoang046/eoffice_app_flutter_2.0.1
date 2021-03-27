import 'package:app_eoffice/models/loginItem.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/main.dart';
import 'package:load/load.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_eoffice/widget/FormLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/block/login_bloc/Auth_event.dart';
import 'package:app_eoffice/block/login_bloc/auth_state.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

// void main() => runApp(
//       LoadingProvider(
//         themeData: LoadingThemeData(
//             // tapDismiss: false,
//             ),
//         child: Login(),
//       ),
//     );

// class Login extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         navigatorKey: SimpleRouter.getKey(),
//         title: 'Đăng nhập',
//         theme: ThemeData(
//           primaryColor: Colors.blue,
//         ),
//         home: MultiBlocProvider(
//           providers: [
//             BlocProvider<BlocAuth>(
//                 create: (BuildContext context) => BlocAuth()),
//           ],
//           child: Mylogin(),
//         ));
//   }
// }

class Mylogin extends StatefulWidget {
  _Mylogin createState() => _Mylogin();
}

bool isFlag = false;
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _Mylogin extends State<Mylogin> {
  @override
  void initState() {
    super.initState();
  }

  bool _isSelected = false;

  // ignore: must_call_super
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
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
        if (state is LoadingState && basemessage.length > 0) {
          Toast.show(basemessage, context,
              duration: 3, gravity: Toast.TOP, backgroundColor: Colors.red);
          basemessage = '';
        }
        if (state is LogedSate) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => Mymain(
                  datatabindex: 0,
                ),
              ),
              (route) => false);
        }
        return;
      },
      builder: (context, state) {
        return ScreenUtilInit(
            builder: () => SafeArea(
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
                                                child: radioButton(_isSelected),
                                              ),
                                              SizedBox(
                                                width: 8.0,
                                              ),
                                              Text("Ghi nhớ đăng nhập",
                                                  style:
                                                      TextStyle(fontSize: 12))
                                            ],
                                          ),
                                          _onLoginClick1()
                                        ],
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
                )));
      },
    );
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      String _username = _usernameController.text;
      String _password = _passwordController.text;
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
      if (state is LoadingState) {
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
