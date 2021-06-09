import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class MyComBo_NhomDonVi extends StatefulWidget {
  @override
  _MyComBo_NhomDonVi createState() => new _MyComBo_NhomDonVi();
}

List<int> lstnhomdonvi = new List<int>();
DuThaoVanBan_api objapi = new DuThaoVanBan_api();

class _MyComBo_NhomDonVi extends State<MyComBo_NhomDonVi> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  void initState() {
    lstnhomdonvi = [];
  }

  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsnhomdonvi = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: objapi.getnhomdonvi(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NhomNguoiDungItem> list = snapshot.data;
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
                selectedItems: selectedItemsnhomdonvi,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm đơn vị"),
                ),
                searchHint: "Chọn nhóm đơn vị",
                onChanged: (value) {
                  lstnhomdonvi = new List<int>();
                  setState(() {
                    selectedItemsnhomdonvi = value;
                    selectedItemsnhomdonvi.forEach((element) {
                      lstnhomdonvi.add(int.parse(lst[element].value));
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
