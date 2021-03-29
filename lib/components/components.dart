import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonLogin extends MaterialButton {
  ButtonLogin({
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.black,
    this.label = 'OK',
    this.labelColor = Colors.blue,
    this.mOnPressed,
    this.isLoading = false,
    this.height,
    this.minWidth,
  });
  final minWidth;
  final height;
  final bool isLoading;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final Color labelColor;
  final VoidCallback mOnPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF6078ea).withOpacity(.3),
                  offset: Offset(0.0, 8.0),
                  blurRadius: 8.0)
            ]),
        child: Material(
          color: Colors.transparent,
          child: MaterialButton(
            onPressed: () async {
              mOnPressed();
            },
            child: Center(
              child: Text(label,
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, letterSpacing: 1.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class Alert extends AlertDialog {
  final String titleText;
  final String contentText;

  Alert({this.titleText, this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: Text(titleText),
      content: Text(contentText),
      actions: <Widget>[
        RaisedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok'),
        )
      ],
    );
  }
}

class ButtonAction extends MaterialButton {
  ButtonAction({
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.black,
    this.label = 'OK',
    this.labelColor = Colors.blue,
    this.mOnPressed,
    this.height,
    this.minWidth,
    this.icons,
  });
  final minWidth;
  final height;
  final Color backgroundColor;
  final Color borderColor;
  final String label;
  final Color labelColor;
  final IconData icons;
  final VoidCallback mOnPressed;
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 10, 25, 5),
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            onPressed: () {
              mOnPressed();
            },
            color: backgroundColor,
            child: Row(
              children: [
                Icon(
                  icons,
                  size: 17,
                  color: Colors.white,
                ),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: labelColor),
                ),
              ],
            )));
  }
}
