import 'package:app_eoffice/utils/Base.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';

class ViewVanBanDiPanel extends StatelessWidget {
  // Stream<List<VanBanDenItem>> lststream;
  VanBanDiItem obj;
  ViewVanBanDiPanel({@required this.obj});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
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
          // border: Border.all(
          //   color: Colors.red[500],
          // ),
        ),
        // padding: EdgeInsets.all(7),
        // margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              containerRow(
                  'Ngày văn bản: ',
                  obj.ngaybanhanh != null
                      ? formatDate(DateTime.parse(obj.ngaybanhanh),
                          [dd, '/', mm, '/', yyyy])
                      : ''),
              containerRow(
                  'Hạn xử lý: ',
                  obj.hanxuly != null
                      ? formatDate(
                          DateTime.parse(obj.hanxuly), [dd, '/', mm, '/', yyyy])
                      : ''),
              containerRow('Đơn vị soạn thảo: ', obj.tendonvisoanthao),
              containerRow('Người ký: ', obj.tennguoiky),
              containerRow('Số ký hiệu: ', obj.sokyhieu),
              containerRow('Sổ văn bản: ', obj.tensovanban),
              containerRow('Loại văn bản: ', obj.tenloaivanban),
              containerRow('Trích yếu: ', obj.trichyeu),
              containerRow('Đơn vị nhận: ', obj.strdonvinhan),
              containerRow('Nhóm đơn vị nhận: ', obj.strnhomdonvinhan),
              containerRow('Người nhận: ', obj.strnguoinhan),
              for (var i = 0; i < obj.lstdanhmucgiatri.length; i++)
                containerRow(obj.lstdanhmucgiatri[i].tenDanhMuc + ": ",
                    obj.lstdanhmucgiatri[i].ten),
              if (obj.lstfile.length > 0) containerRow('File đính kèm: ', ''),
              for (var i = 0; i < obj.lstfile.length; i++)
                containerRowViewfile(obj.lstfile[i].ten, obj.lstfile[i].id,
                    obj.lstfile[i].filelink),
            ],
          ),
        ));
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
