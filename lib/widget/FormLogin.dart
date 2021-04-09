import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool showPassword = true;
String _username = '';

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyFormLogin();
  }
}

class MyFormLogin extends StatefulWidget {
  final TextEditingController username;
  final TextEditingController pass;
  const MyFormLogin({this.username, this.pass});
  @override
  _MyFormLogin createState() => new _MyFormLogin();
}

SharedPreferences sharedPreferences;
bool isloadlogin = true;

class _MyFormLogin extends State<MyFormLogin> {
  @override
  void initState() {
    isloadlogin = true;
    loadlogin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            tendangnhap(),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Text("Mật khẩu",
                style: TextStyle(fontSize: ScreenUtil().setSp(15))),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    obscureText: showPassword,
                    controller: widget.pass,
                    decoration: InputDecoration(
                        hintText: "Mật khẩu",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 12.0)),

                    // ignore: missing_return
                    validator: (value) {
                      if (value.isEmpty) return 'Vui lòng nhập mật khẩu';
                    },
                  ),
                ),
                handleShowPass()
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (isloadlogin != true)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Text(
                          "Không phải tôi",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(12)),
                        ),
                        onTap: () {
                          setState(() {
                            isloadlogin = true;
                            isSelectedremember = false;
                          });
                        },
                      ),
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil().setSp(13)),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thông báo'),
                                content: Text(
                                    'Liên hệ với quản trị hệ thống để lấy lại mật khẩu'),
                              );
                            });
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  loadlogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String strurrn = '';

    strurrn = sharedPreferences.getString("username") != null
        ? sharedPreferences.getString("username")
        : '';
    setState(() {
      if (strurrn == null || (strurrn != null && strurrn.length <= 0))
        isloadlogin = true;
      else {
        isloadlogin = false;
        _username = strurrn;
      }
    });
  }

  tendangnhap() {
    if (isloadlogin) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tên đăng nhập",
              style: TextStyle(fontSize: ScreenUtil().setSp(15))),
          TextFormField(
              controller: widget.username,
              decoration: InputDecoration(
                  hintText: "Tên đăng nhập",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
              // ignore: missing_return
              validator: (value) {
                if (value.isEmpty) {
                  return 'Vui lòng nhập tên đăng nhập';
                }
              })
        ],
      );
    } else {
      return RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: 'Xin chào, ',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
        TextSpan(
            text: _username,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))
      ]));
    }
  }

  handleShowPass() {
    return IconButton(
      icon: !showPassword
          ? Icon(Icons.remove_red_eye, color: Colors.blue, size: 20)
          : Icon(Icons.visibility_off, color: Colors.blue, size: 20),
      onPressed: () {
        setState(() => showPassword = !showPassword);
      },
    );
  }
}
