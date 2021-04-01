import 'package:app_eoffice/models/LichLamViecItem.dart';
import 'package:app_eoffice/models/NoiDungLichItem.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LichlamViecListItem extends StatelessWidget {
  final NoiDungLichItem obj;
  LichlamViecListItem({this.obj, List<NoiDungLichItem> topStories});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        decoration: BoxDecoration(
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
        margin: EdgeInsets.fromLTRB(3, 3, 0, 0),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: ListTile(
          onTap: () {
            // _ontap(obj);
          },
          leading: Container(
            // width: 40,
            margin: EdgeInsets.fromLTRB(0, 0, 2, 0),
            child: Text(obj.thu +
                '\n' +
                (obj.listlich.first.thoigianbatdau != null
                    ? formatDate(
                        DateTime.parse(obj.listlich.first.thoigianbatdau),
                        [dd, '/', mm, '/', yyyy])
                    : '')),
          ),
          title: Column(
            children: [
              for (int i = 0; i < obj.listlich.length; i++)
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: (obj.listlich[i].thoigianbatdau != null
                              ? formatDate(
                                  DateTime.parse(
                                      obj.listlich[i].thoigianbatdau),
                                  [HH, ':', mm])
                              : '') +
                          ' ' +
                          obj.listlich[i].noidung,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )),
                  if (obj.listlich[i].diadiem != null)
                    TextSpan(
                        text: ('\nĐĐ: '),
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  if (obj.listlich[i].diadiem != null)
                    TextSpan(
                        text: (obj.listlich[i].diadiem),
                        style: TextStyle(color: Colors.black54)),
                  if (obj.listlich[i].thanhphanthamdu != null)
                    TextSpan(
                        text: ('\nTP: '),
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold)),
                  if (obj.listlich[i].thanhphanthamdu != null)
                    TextSpan(
                        text: (obj.listlich[i].thanhphanthamdu),
                        style: TextStyle(color: Colors.black54)),
                ]))
            ],
          ),
        ),
      ),
    );
  }
}
