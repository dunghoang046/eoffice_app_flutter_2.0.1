import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_html/flutter_html.dart';

class NguoiDungViewPanel extends StatelessWidget {
  NguoiDungItem obj;
  NguoiDungViewPanel({@required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     left: BorderSide(color: Colors.green, width: 5),
      //   ),
      // ),
      padding: EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          containerRow('Tên người dùng: ', obj.tenhienthi),
          containerRow('Tên truy cập: ', obj.tentruycap),
          if (obj.thutu != null) containerRow('Thứ tự: ', obj.thutu.toString()),
          containerRow(
              'Ngày sinh: ',
              (obj.ngaysinh != null
                  ? formatDate(DateTime.parse(obj.ngaysinh),
                      [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
                  : '')),
          if (obj.email != null) containerRow('Email: ', obj.email),
          if (obj.dienthoai != null)
            containerRow('Điện thoại: ', obj.dienthoai),
          if (obj.didong != null) containerRow('Di động: ', obj.didong),
          if (obj.diachi != null) containerRow('Địa chỉ: ', obj.diachi),
          if (obj.lstvaitro != null)
            containerRow(
                'Vai trò: ', obj.lstvaitro.map((e) => e.ten).join(', ')),
          if (obj.lstthongtin != null)
            containerRownotborder(
                'Đơn vị/Nhóm/Đại diện: ',
                obj.lstthongtin
                    .map((e) =>
                        e.tendonvi +
                        ' | ' +
                        e.tennhomnguoidung +
                        ' | ' +
                        ((e.isdaidien == true) ? 'có' : 'Không'))
                    .join(', ')),
        ],
      ),
    );
  }

  Widget containerRownotborder(String label, String value) => Container(
        // decoration: BoxDecoration(
        //   border: Border(
        //     bottom: BorderSide(
        //       color: Colors.black26,
        //     ),
        //     // right: BorderSide(color: Colors.green, width: 6),
        //   ),
        // ),
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: RichText(
                    softWrap: true,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: label + '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: value, style: TextStyle(color: Colors.black))
                    ])))
          ],
        ),
      );

  Widget containerRow(String label, String value) => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
            ),
            // right: BorderSide(color: Colors.green, width: 6),
          ),
        ),
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: RichText(
                    softWrap: true,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: label + '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: value, style: TextStyle(color: Colors.black))
                    ])))
          ],
        ),
      );

  Widget containerRowHtml(String label, String value) => Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black26,
            ),
            // right: BorderSide(color: Colors.green, width: 6),
          ),
        ),
        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Expanded(child: Html(data: "<b>" + label + "</b>" + value)),
          ],
        ),
      );
}
