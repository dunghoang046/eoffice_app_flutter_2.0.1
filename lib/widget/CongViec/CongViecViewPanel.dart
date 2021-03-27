import 'package:flutter/material.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:date_format/date_format.dart';

class CongViecViewPanel extends StatelessWidget {
  WorkTaskItem obj;
  CongViecViewPanel({@required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.green, width: 5),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        // border: Border.all(
        //   color: Colors.red[500],
        // ),
      ),
      padding: EdgeInsets.all(7),
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: <Widget>[
          containerRow('Tên công việc: ', obj.title),
          containerRow('Mã: ', obj.code),
          containerRow('Người tạo: ', obj.createdUserName),
          containerRow(
              'Ngày tạo: ',
              obj.createdDate != null
                  ? formatDate(
                      DateTime.parse(obj.createdDate), [dd, '/', mm, '/', yyyy])
                  : ''),
          containerRow(
              '',
              (obj.startDate != null
                      ? formatDate(DateTime.parse(obj.startDate),
                          [dd, '/', mm, '/', yyyy])
                      : '') +
                  (obj.endDate != null
                      ? ' - ' +
                          formatDate(DateTime.parse(obj.endDate),
                              [dd, '/', mm, '/', yyyy])
                      : '')),
          if (obj.ltsUserPerform.length > 0)
            containerRow('Thực hiện: ',
                obj.ltsUserPerform.map((value) => value.fullName).join(', ')),
          if (obj.ltsGroupPerform.length > 0)
            containerRow('Đơn vị xử lý: ',
                obj.ltsGroupPerform.map((value) => value.fullName).join(', ')),
          if (obj.ltsUserGroupPerform.length > 0)
            containerRow(
                'Nhóm thực hiện: ',
                obj.ltsUserGroupPerform
                    .map((value) => value.fullName)
                    .join(', ')),
          containerRow('Mô tả: ', obj.description),
          containerRow('Trạng thái: ', obj.strTrangthai),
          containerRow('Tiến độ: ', obj.progress),
          if (obj.lstfile.length > 0) containerRow('File đính kèm: ', ''),
          for (var i = 0; i < obj.lstfile.length; i++)
            containerRow('', obj.lstfile[i].ten),
        ],
      ),
    );
  }

  var underlineStyle =
      TextStyle(decoration: TextDecoration.underline, color: Colors.black);
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
}
