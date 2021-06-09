import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_LanhdaoTrinhDT extends StatefulWidget {
  @override
  Future<LanhDaoTrinhDTItem> lstnguoidung;
  MyComBo_LanhdaoTrinhDT({this.lstnguoidung});
  _MyComBo_LanhdaoTrinhDT createState() => new _MyComBo_LanhdaoTrinhDT();
}

String lanhdaotrinhid;

class _MyComBo_LanhdaoTrinhDT extends State<MyComBo_LanhdaoTrinhDT> {
  @override
  void initState() {
    lanhdaotrinhid = '';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  Widget combo() => Center(
          child: FutureBuilder(
        future: widget.lstnguoidung,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            LanhDaoTrinhDTItem list = snapshot.data;
            if (list.lstlanhdao.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.lstlanhdao.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list.lstlanhdao[i].tenhienthi),
                  value: list.lstlanhdao[i].id.toString(),
                ));
              }
              return SearchableDropdown.single(
                items: lst,
                value: lanhdaotrinhid,
                hint: "Chọn lãnh đạo",
                searchHint: null,
                onChanged: (value) {
                  setState(() {
                    lanhdaotrinhid = value;
                  });
                },
                dialogBox: false,
                isExpanded: true,
                menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
              );
            } else
              return notrecord();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
}
