import 'dart:ui';

import 'package:app_eoffice/block/login_bloc/Auth_event.dart';
import 'package:app_eoffice/block/login_bloc/auth_bloc.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/views/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main.dart';

Widget lstmenu(BuildContext context) => Drawer(
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
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Mymain(
                            datatabindex: 0,
                          )))
                },
              ),
              ListTile(
                leading: Icon(Icons.verified_user),
                title: Text('Văn bản đến'),
                onTap: () => {
                  // Navigator.of(context).pushAndRemoveUntil(
                  //     MaterialPageRoute(
                  //       builder: (context) => Mymain(
                  //         datatabindex: 1,
                  //       ),
                  //     ),
                  //     (route) => false)
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Văn bản đi'),
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Mymain(
                            datatabindex: 2,
                          )))
                },
              ),
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Công việc'),
                onTap: () => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => Mymain(
                          datatabindex: 3,
                        ),
                      ),
                      (route) => false)
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

void linktab(context) {
  tabIndex = 2;
  Navigator.push(
      context, new MaterialPageRoute(builder: (context) => new MyApp()));
}

void logout(BuildContext context) {
  isautologin = false;
  BlocProvider.of<BlocAuth>(context).add(LogoutEvent());
}
