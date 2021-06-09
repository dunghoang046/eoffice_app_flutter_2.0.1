import 'package:app_eoffice/utils/Base.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';

// ignore: must_be_immutable
class ViewVanBanPanel extends StatelessWidget {
  // Stream<List<VanBanDenItem>> lststream;
  VanBanDenItem obj;
  ViewVanBanPanel({@required this.obj});

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
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: <Widget>[
          containerRow(
              'Ngày đến: ',
              obj.ngayden != null
                  ? formatDate(
                      DateTime.parse(obj.ngayden), [dd, '/', mm, '/', yyyy])
                  : ''),
          containerRow('Cơ quan gửi đến: ', obj.tencoquanbanhanh),
          containerRow(
              'Ngày ban hành: ',
              obj.ngaybanhanh != null
                  ? formatDate(
                      DateTime.parse(obj.ngaybanhanh), [dd, '/', mm, '/', yyyy])
                  : ''),
          containerRow('Số ký hiệu: ', obj.sokyhieu),
          containerRow('Sổ văn bản: ', obj.tensovanban),
          containerRow('Loại văn bản: ', obj.tenloaivanban),
          containerRow('Trích yếu: ', obj.trichyeu),
          if (obj.trangthaivanbanid == 0)
            containerRow('Trạng thái người dùng: ', 'Chưa xử lý'),
          if (obj.trangthaivanbanid == 1)
            containerRow('Trạng thái người dùng: ', 'Đang xử lý'),
          if (obj.trangthaivanbanid == 3)
            containerRow('Trạng thái người dùng: ', 'Đã xử lý'),
          if (obj.isxuly == null) containerRow('Trạng thái VB: ', 'Chưa xử lý'),
          if (obj.isxuly == false)
            containerRow('Trạng thái VB: ', 'Đang xử lý'),
          if (obj.lstdanhmucgiatri != null)
            for (var i = 0; i < obj.lstdanhmucgiatri.length; i++)
              containerRow(obj.lstdanhmucgiatri[i].tenDanhMuc + ": ",
                  obj.lstdanhmucgiatri[i].ten),
          if (obj.isxuly == true) containerRow('Trạng thái VB: ', 'Đã xử lý'),
          if (obj.lstfile.length > 0) containerRow('File đính kèm: ', ''),
          for (var i = 0; i < obj.lstfile.length; i++)
            containerRowViewfile(
                obj.lstfile[i].ten, obj.lstfile[i].id, obj.lstfile[i].filelink),
        ],
      ),
    );
  }

  var underlineStyle =
      TextStyle(decoration: TextDecoration.underline, color: Colors.black);
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
