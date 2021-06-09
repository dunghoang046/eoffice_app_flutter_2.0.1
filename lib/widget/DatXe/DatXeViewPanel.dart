import 'package:app_eoffice/models/ThongTinDatXeItem.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter_html/flutter_html.dart';

class DatXeViewPanel extends StatelessWidget {
  ThongTinDatXeItem obj;
  DatXeViewPanel({@required this.obj});

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
      child: Column(
        children: <Widget>[
          containerRow('Người đặt: ', obj.tennguoitao),
          containerRow('Phòng ban: ', obj.tenphongban),
          containerRow(
              'Thời gian: ',
              (obj.thoigianbatdau != null
                      ? formatDate(DateTime.parse(obj.thoigianbatdau),
                          [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
                      : '') +
                  (obj.thoigianketthuc != null
                      ? ' - ' +
                          formatDate(DateTime.parse(obj.thoigianketthuc),
                              [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn])
                      : '')),
          if (obj.songuoi != null)
            containerRow('Số ngưởi: ', obj.songuoi.toString()),
          if (obj.mota != null) containerRow('Nội dung: ', obj.mota),
          if (obj.diemden != null && obj.diemden.length > 0)
            containerRow('Điểm đến: ', obj.diemden),
          if (obj.diemdon != null && obj.diemdon.length > 0)
            containerRow('Điểm đón: ', obj.diemdon),
          if (obj.tennguoilaixe != null && obj.tennguoilaixe.length > 0)
            containerRow('Lái xe: ', obj.tennguoilaixe),
          if (obj.trangthaiid == 3) containerRow('Xe: ', obj.tendanhmucxe),
          if (obj.bienso != null && obj.bienso.length > 0)
            containerRow('Biển số: ', obj.bienso),
          if (obj.trangthaiid == 0 || obj.trangthaiid == 4)
            containerRow('Trạng thái: ', 'Tạo mơi'),
          if (obj.trangthaiid == 1) containerRow('Trạng thái: ', 'Chờ duyệt'),
          if (obj.trangthaiid == 3) containerRow('Trạng thái: ', 'Đã duyệt'),
          if (obj.trangthaiid == 2) containerRow('Trạng thái: ', 'Từ chối'),
          if (obj.trangthaiid == 3)
            containerRow('Người phê duyệt: ', obj.tennguoiquantri),

          if (obj.trangthaiid == 2) containerRow('Lý do: ', obj.lydo),
          // containerRow('Trạng thái: ', obj.strTrangthai),
          if (obj.lstfile != null && obj.lstfile.length > 0)
            containerRow('File đính kèm: ', ''),
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
