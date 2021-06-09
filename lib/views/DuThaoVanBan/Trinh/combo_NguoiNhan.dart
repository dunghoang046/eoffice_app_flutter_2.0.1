import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class MyComBo_NguoiNhan extends StatefulWidget {
  @override
  _MyComBo_NguoiNhan createState() => new _MyComBo_NguoiNhan();
}

List<int> lstnguoinhan = new List<int>();
DuThaoVanBan_api objapi = new DuThaoVanBan_api();

class _MyComBo_NguoiNhan extends State<MyComBo_NguoiNhan> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  void initState() {
    lstnguoinhan = [];
  }

  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsnguoinhan = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: objapi.getcanbolienquan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NguoiDungItem> list = snapshot.data;
            if (list.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list[i].tenhienthi),
                  value: list[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsnguoinhan,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người nhận"),
                ),
                searchHint: "Chọn người nhận",
                onChanged: (value) {
                  lstnguoinhan = new List<int>();
                  setState(() {
                    selectedItemsnguoinhan = value;
                    selectedItemsnguoinhan.forEach((element) {
                      lstnguoinhan.add(int.parse(lst[element].value));
                    });
                  });
                },
                doneButton: 'Hoàn thành',
                closeButton: (selectedItems) {
                  return ("Đồng ý");
                },
                isExpanded: true,
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
