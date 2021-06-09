import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _BaseWidget extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

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

Widget horizontalLine() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: ScreenUtil().setWidth(120),
        height: 1.0,
        color: Colors.black26.withOpacity(.2),
      ),
    );

Widget containerRow(String label, String value) => Container(
      padding: EdgeInsets.fromLTRB(0, 2, 10, 2),
      child: Row(
        children: <Widget>[
          Expanded(
              child: RichText(
                  softWrap: true,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: label + '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(text: value, style: TextStyle(color: Colors.black))
                  ])))
        ],
      ),
    );
Widget notrecord() => Center(
      child: Text(
        'Không có bản ghi nào',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
