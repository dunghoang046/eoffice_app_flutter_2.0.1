import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:app_eoffice/models/VanBanDiYKienItem.dart';

class DuThaoVanBanYkienItemList extends StatelessWidget {
  final List<VanBanDiYKienItem> lstobj;
  DuThaoVanBanYkienItemList({@required this.lstobj});

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
    Widget content(VanBanDiYKienItem obj, int index) => Container(
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
                  containerRow('Người dùng: ', obj.tennguoidung),
                  containerRow(
                    'Thời gian: ',
                    obj.ngaytao != null
                        ? formatDate(DateTime.parse(obj.ngaytao),
                            [dd, '/', mm, '/', yyyy])
                        : '',
                  ),
                  containerRow('Nội dung: ', obj.noidung),
                  containerRow('Người duyệt: ', obj.tennguoiky),
                  containerRow(
                    'Hạn xử lý: ',
                    obj.hanxuly != null
                        ? formatDate(DateTime.parse(obj.hanxuly),
                            [dd, '/', mm, '/', yyyy])
                        : '',
                  ),
                  if (obj.lstfile.length > 0)
                    containerRow('File đính kèm: ', ''),
                  for (var i = 0; i < obj.lstfile.length; i++)
                    containerRow('', obj.lstfile[i].ten),
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
