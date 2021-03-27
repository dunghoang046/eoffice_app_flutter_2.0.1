import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_PhongBanLienQuan extends StatefulWidget {
  @override
  _MyComBo_PhongBanLienQuan createState() => new _MyComBo_PhongBanLienQuan();
}

DuThaoVanBan_api objapi = new DuThaoVanBan_api();
List<int> lstphongbanlienquan = new List<int>();

class _MyComBo_PhongBanLienQuan extends State<MyComBo_PhongBanLienQuan> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemslstpblq = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: objapi.getphongbanlienquan(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<DonViItem> list = snapshot.data;
            if (list.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list[i].ten),
                  value: list[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemslstpblq,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn phòng ban liên quan"),
                ),
                searchHint: "Chọn phòng ban liên quan",
                onChanged: (value) {
                  lstphongbanlienquan = new List<int>();
                  setState(() {
                    selectedItemslstpblq = value;
                    selectedItemslstpblq.forEach((element) {
                      lstphongbanlienquan.add(int.parse(lst[element].value));
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
