import 'package:app_eoffice/services/Base_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/models/VanBanDenGuiNhanItem.dart';

class VanBanDenGUiNhanItemList extends StatelessWidget {
  final List<VanBanDenGuiNhanItem> lstobj;
  VanBanDenGUiNhanItemList({@required this.lstobj});

  @override
  Widget build(BuildContext context) {
    Widget containerRow(String label, String value) => Container(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
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
        ));
    Widget containerRowTrangThai(String label, String value) => Container(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: RichText(
                    softWrap: true,
                    text: TextSpan(children: <InlineSpan>[
                      TextSpan(
                          text: label + '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      WidgetSpan(
                          child: Container(
                        color: value == "Trả lại"
                            ? Colors.red[600]
                            : (value == "Đã gửi"
                                ? Colors.yellow[800]
                                : Colors.green[600]),
                        padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ])))
          ],
        ));
    Widget content(VanBanDenGuiNhanItem obj, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: Colors.green, width: 5),
            ),
            shape: BoxShape.rectangle,
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
          margin: EdgeInsets.fromLTRB(15, 8, 10, 2),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: ListTile(
              onTap: () {},
              subtitle: Column(
                children: <Widget>[
                  containerRow('Người gửi: ', obj.tennguoigui),
                  containerRow('Người nhận: ', obj.tennguoinhan),
                  containerRow(
                      'Đơn vị nhận: ',
                      (obj.tendonvinhan == null || obj.tendonvinhan.length <= 0)
                          ? nguoidungsession.tendonvi
                          : obj.tendonvinhan),
                  containerRow(
                    'Thời gian gửi: ',
                    obj.thoigiangui != null
                        ? formatDate(DateTime.parse(obj.thoigiangui),
                            [dd, '/', mm, '/', yyyy])
                        : '',
                  ),
                  containerRow(
                    'Thời gian nhận: ',
                    obj.thoigiannhan != null
                        ? formatDate(DateTime.parse(obj.thoigiannhan),
                            [dd, '/', mm, '/', yyyy])
                        : '',
                  ),
                  containerRowTrangThai(
                      'Trạng thái: ',
                      obj.trangthai != 2
                          ? (obj.thoigiannhan == null ? 'Đã gửi' : 'Đã nhận')
                          : "Trả lại"),
                ],
              )),
        );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: lstobj.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == lstobj.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return content(lstobj[index], index + 1);
        },
      ),
    );
  }
}
