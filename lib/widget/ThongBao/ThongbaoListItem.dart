import 'package:app_eoffice/models/ThongBaoItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ThongBaoListItem extends StatelessWidget {
  final ThongBaoItem obj;
  ThongBaoListItem({this.obj, List<ThongBaoItem> topStories});
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
              title: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        child: Expanded(
                          child: Text(obj.ten,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Expanded(
                          child: Text(obj.mota, style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   child: Expanded(
                  //     child: Text(obj.mota),
                  //   ),
                  // )
                ],
              ))),
    );
  }
}
