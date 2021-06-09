import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_html/flutter_html.dart';

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
      ),
      padding: EdgeInsets.all(7),
      // margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
          if (obj.ltsUserFollow.length > 0)
            containerRow('Theo dõi: ',
                obj.ltsUserFollow.map((value) => value.fullName).join(', ')),
          if (obj.ltsGroupPerform.length > 0)
            containerRow('Đơn vị thực hiện: ',
                obj.ltsGroupPerform.map((value) => value.tendonvi).join(', ')),
          if (obj.ltsGroupFollow.length > 0)
            containerRow('Đơn vị theo dõi: ',
                obj.ltsGroupFollow.map((value) => value.tendonvi).join(', ')),
          if (obj.ltsUserGroupPerform.length > 0)
            containerRow(
                'Nhóm thực hiện: ',
                obj.ltsUserGroupPerform
                    .map((value) => value.fullName)
                    .join(', ')),
          if (obj.ltsUserGroupFollow.length > 0)
            containerRow(
                'Nhóm theo dõi: ',
                obj.ltsUserGroupFollow
                    .map((value) => value.fullName)
                    .join(', ')),
          if (obj.description != null)
            containerRowHtml('Mô tả: ', obj.description),
          containerRow('Trạng thái: ', obj.strTrangthai),
          if (obj.progress != null && obj.progress > 0)
            containerRow('Tiến độ: ', obj.progress.toString()),
          if (obj.lstfile.length > 0) containerRow('File đính kèm: ', ''),
          for (var i = 0; i < obj.lstfile.length; i++)
            containerRowViewfile(
                obj.lstfile[i].ten, obj.lstfile[i].id, obj.lstfile[i].filelink),
        ],
      ),
    );
  }

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
