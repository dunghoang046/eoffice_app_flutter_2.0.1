import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

class DuThaoVanBanGuiNhanpanel extends StatelessWidget {
  List<VanBanDiGuiNhanItem> lstobjguinhan;
  DuThaoVanBanGuiNhanpanel({@required this.lstobjguinhan});
  List<String> litems = ["1", "2", "Third", "4"];
  @override
  Widget build(BuildContext context) {
    return _buildView(topStories: lstobjguinhan);
  }

  Widget _buildView({List<VanBanDiGuiNhanItem> topStories}) {
    return ListView.builder(
      itemCount: topStories.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
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
          margin: EdgeInsets.fromLTRB(15, 8, 10, 0),
          padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
          child: ListTile(
              subtitle: Column(
            children: <Widget>[
              if (topStories[index].tennguoigui.length > 0)
                containerRow(
                  'Người gửi: ',
                  topStories[index].tennguoigui,
                ),
              if (topStories[index].tennguoinhan.length > 0)
                containerRow(
                    'Tên người nhận: ', topStories[index].tennguoinhan),
              if (topStories[index].thoigiangui != null)
                containerRow(
                    'Thời gian gửi: ',
                    formatDate(DateTime.parse(topStories[index].thoigiangui),
                        [dd, '/', mm, '/', yyyy])),
              if (topStories[index].thoigiannhan != null)
                containerRow(
                    'Thời gian nhận: ',
                    formatDate(DateTime.parse(topStories[index].thoigiannhan),
                        [dd, '/', mm, '/', yyyy])),
            ],
          )),
        );
      },
    );
  }

  Widget containerRow(String label, String value) => Container(
        padding: EdgeInsets.fromLTRB(0, 2, 10, 2),
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
