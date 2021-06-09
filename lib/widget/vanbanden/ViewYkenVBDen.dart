import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDenYkienItem.dart';

class VanBanDenYKienItemList extends StatelessWidget {
  final List<VanBanDenYKienItem> lstobj;
  VanBanDenYKienItemList({@required this.lstobj});

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
    Widget content(VanBanDenYKienItem obj, int index) => Container(
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
              title: Text(obj.noidung != null ? obj.noidung : '',
                  style: TextStyle(color: Colors.blue, fontSize: 16)),
              subtitle: Column(
                children: <Widget>[
                  containerRow('Người dùng: ', obj.tennguoitao),
                  containerRow(
                      'Thực hiện: ',
                      obj.strDonViDauMoi +
                          (obj.strNguoiDaumoi.length > 0
                              ? (obj.strDonViDauMoi.length > 0 ? ', ' : '') +
                                  obj.strNguoiDaumoi
                              : '')),
                  containerRow(
                      'Theo dõi: ',
                      obj.strDonViPhoiHop +
                          (obj.strNguoiPhoiHop.length > 0
                              ? (obj.strDonViPhoiHop.length > 0 ? ', ' : '') +
                                  obj.strNguoiPhoiHop
                              : ''))
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
