import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';
import 'package:app_eoffice/views/VanBanDi/VanBandi_Chtiet.dart';

class VanBanDiListItem extends StatelessWidget {
  final VanBanDiItem obj;
  VanBanDiListItem({@required this.obj, List<VanBanDiItem> topStories});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.green, width: 13),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyVanVanDiChiTiet(
                            id: obj.id,
                          )));
            },
            title: Text(obj.trichyeu != null ? obj.trichyeu : '',
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
            subtitle: Column(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Icon(
                          Icons.alarm,
                          size: 14,
                        )),
                    Expanded(
                      // margin: const EdgeInsets.only(left: 4.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                        child: Text(
                          obj.ngaybanhanh != null
                              ? formatDate(DateTime.parse(obj.ngaybanhanh),
                                  [dd, '/', mm, '/', yyyy])
                              : '',
                          style: TextStyle(),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                        child: Icon(
                          Icons.airplanemode_active,
                          size: 14,
                        )),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 3, 0, 0),
                        child: Text(
                          obj.tendonvisoanthao != null
                              ? obj.tendonvisoanthao
                              : '',
                        ),
                      ),
                    )
                  ],
                ),
                if (obj.sokyhieu != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                          child: Icon(
                            Icons.unfold_more,
                            size: 14,
                          )),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(4, 3, 0, 0),
                          child: Text(
                            obj.sokyhieu != null ? obj.sokyhieu : '',
                          ),
                        ),
                      )
                    ],
                  ),
              ],
            )),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive',
          color: Colors.blue,
          icon: Icons.archive,
          // onTap: () => _showSnackBar('Archive'),
        ),
        IconSlideAction(
          caption: 'Share',
          color: Colors.indigo,
          icon: Icons.share,
          // onTap: () => _showSnackBar('Share'),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Sửa',
          color: Colors.black45,
          icon: Icons.more_horiz,
          // onTap: () => _showSnackBar('More'),
        ),
        IconSlideAction(
          caption: 'Xóa',
          color: Colors.red,
          icon: Icons.delete,
          // onTap: () => _showSnackBar('Delete'),
        ),
      ],
    );
  }
}
