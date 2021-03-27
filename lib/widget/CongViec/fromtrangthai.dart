import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void formtrangthai(BuildContext context) {
  Alert(
    context: context,
    // type: AlertType.info,
    style: alertStyle,
    title: "Trạng thái",
    // desc: "Flutter is more awesome with RFlutter Alert.",
    content: SingleChildScrollView(
      child: Theme(
        child: Column(
          children: [],
        ),
        data: ThemeData(
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
            accentColor: Colors.blue,
            primaryColor: Colors.blue),
      ),
    ),
    buttons: [
      DialogButton(
          onPressed: () {
            // _clickreject();
          },
          width: 100,
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                // size: 17,
                color: Colors.white,
              ),
              Text(
                'Đồng ý',
                textAlign: TextAlign.center,
                style: TextStyle(color: white, fontSize: 17),
              ),
            ],
          )),
      DialogButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.close,
              // size: 17,
              color: Colors.white,
            ),
            Text(
              'Hủy',
              textAlign: TextAlign.center,
              style: TextStyle(color: white),
            ),
          ],
        ),
        onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
        gradient: LinearGradient(colors: [
          Colors.red,
          Colors.red,
        ]),
      )
    ],
  ).show();
}
