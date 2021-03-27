import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ChiTiet.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';
import 'package:simple_router/simple_router.dart';

class CongViecListItem extends StatelessWidget {
  final WorkTaskItem obj;
  CongViecListItem({@required this.obj, List<WorkTaskItem> topStories});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: obj.status == 3
                    ? Colors.green
                    : (obj.status == 4 ? Colors.red : Colors.amber),
                width: 13),
          ),
          // borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 7), // changes position of shadow
            ),
          ],
        ),
        margin: EdgeInsets.fromLTRB(15, 8, 10, 0),
        padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
        child: ListTile(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => MyCongViecChiTiet(
              //               id: obj.id,
              //             )));
              Navigator.pop(context);
              SimpleRouter.forward(MyCongViecChiTiet(id: obj.id));
            },
            title: Text(obj.title != null ? obj.title : '',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
            subtitle: Column(
              children: <Widget>[
                if (obj.ltsUserPerform.length > 0)
                  containerRow(
                      'Thực hiện: ',
                      obj.ltsUserPerform
                          .map((value) => value.fullName)
                          .join(', ')),
                if (obj.ltsGroupPerform.length > 0)
                  containerRow(
                      'Đơn vị xử lý: ',
                      obj.ltsGroupPerform
                          .map((value) => value.fullName)
                          .join(', ')),
                if (obj.ltsUserGroupPerform.length > 0)
                  containerRow(
                      'Nhóm thực hiện: ',
                      obj.ltsUserGroupPerform
                          .map((value) => value.fullName)
                          .join(', ')),
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
                            : ''))
              ],
            )),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Sửa',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyThemMoiCongViec(
                          id: obj.id,
                        )));
          },
        ),
        IconSlideAction(
          caption: 'Xóa',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }

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
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: value, style: TextStyle(color: Colors.black))
                    ])))
          ],
        ),
      );
}
