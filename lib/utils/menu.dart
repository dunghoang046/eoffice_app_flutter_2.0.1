import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:app_eoffice/views/login.dart';

import '../main.dart';

Widget lstmenu(BuildContext context) => Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            '',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          decoration: BoxDecoration(
              color: Colors.yellow,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/logo.png'))),
        ),
        ListTile(
          leading: Icon(Icons.input),
          title: Text('Thông báo'),
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
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Mymain(
                      datatabindex: 1,
                    )))
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Văn bản đi'),
          onTap: () => {Navigator.of(context).pop()},
        ),
        ListTile(
          leading: Icon(Icons.border_color),
          title: Text('Công việc'),
          onTap: () => {Navigator.of(context).pop()},
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Đăng xuất'),
          onTap: () => {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Mylogin()))
          },
        ),
      ],
    ));
