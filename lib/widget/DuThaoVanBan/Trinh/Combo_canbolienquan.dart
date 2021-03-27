import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_CanBoLienQuan extends StatefulWidget {
  @override
  _MyComBo_CanBoLienQuan createState() => new _MyComBo_CanBoLienQuan();
}

DuThaoVanBan_api objapi = new DuThaoVanBan_api();
List<int> lstcanbolienquan = new List<int>();

class _MyComBo_CanBoLienQuan extends State<MyComBo_CanBoLienQuan> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemscblq = [];
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
                selectedItems: selectedItemscblq,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn cán bộ liên quan"),
                ),
                searchHint: "Chọn cán bộ liên quan",
                onChanged: (value) {
                  lstcanbolienquan = new List<int>();
                  setState(() {
                    selectedItemscblq = value;
                    selectedItemscblq.forEach((element) {
                      lstcanbolienquan.add(int.parse(lst[element].value));
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
