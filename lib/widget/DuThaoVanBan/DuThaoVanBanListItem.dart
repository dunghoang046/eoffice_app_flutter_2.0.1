import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:simple_router/simple_router.dart';

class DuThaoVanBanListItem extends StatelessWidget {
  final DuThaoVanBanItem obj;
  DuThaoVanBanListItem({@required this.obj, List<DuThaoVanBanItem> topStories});
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: obj.trangthaiid == 1
                    ? Colors.grey
                    : (obj.trangthaiid == 10
                        ? Colors.yellow[700]
                        : (obj.trangthaiid == 2
                            ? Colors.blue[300]
                            : Colors.green)),
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
              SimpleRouter.forward(MyDuThaoVanBanChiTiet(
                id: obj.id,
              ));
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
                          Icons.create,
                          size: 14,
                        )),
                    Expanded(
                      // margin: const EdgeInsets.only(left: 4.0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 3, 0, 0),
                        child: Text(
                          obj.ngaytao != null
                              ? formatDate(DateTime.parse(obj.ngaytao),
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
    );
  }
}
