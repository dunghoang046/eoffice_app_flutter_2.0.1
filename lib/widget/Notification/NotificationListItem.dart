import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/views/VanBanDi/VanBandi_Chtiet.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_chitiet.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ChiTiet.dart';
import 'package:app_eoffice/models/NotificationItem.dart';
import 'package:simple_router/simple_router.dart';

class NotificationListItem extends StatelessWidget {
  final NotificationItem obj;
  final List<NotificationItem> topStories;
  NotificationListItem({this.obj, this.topStories});
  @override
  Widget build(BuildContext context) {
    void _ontap(NotificationItem notificationitem) {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => MyNotitest()));

      if (notificationitem.kieuid == 2) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyVanVanDiChiTiet(
                      id: notificationitem.itemid,
                    )));
      }
      if (notificationitem.kieuid == 1 || notificationitem.kieuid == 14) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => VanBanDenChiTiet(
        //               id: notificationitem.itemid,
        //             )));
        SimpleRouter.forward(VanBanDenChiTiet(id: notificationitem.itemid));
      }
      if (notificationitem.kieuid == 3) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyDuThaoVanBanChiTiet(id: notificationitem.itemid)));
      }
      if (notificationitem.kieuid == 8) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyCongViecChiTiet(
                      id: notificationitem.itemid,
                    )));
      }
    }

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
              _ontap(obj);
              topStories.remove(obj);
            },
            title: Text(obj.noidung != null ? obj.noidung : '',
                style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            subtitle: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                        child: Icon(
                          Icons.alarm,
                          size: 13,
                        )),
                    Expanded(
                      // margin: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        obj.tennguoigui +
                            ' gửi lúc: ' +
                            (obj.ngaytao != null
                                ? formatDate(DateTime.parse(obj.ngaytao),
                                    [dd, '/', mm, '/', yyyy])
                                : ''),
                        style: TextStyle(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
