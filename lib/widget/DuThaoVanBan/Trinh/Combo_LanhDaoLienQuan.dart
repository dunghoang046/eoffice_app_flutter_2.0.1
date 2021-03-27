import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_LanhdaoLienQuan extends StatefulWidget {
  Future<LanhDaoTrinhDTItem> lstnguoidung;
  MyComBo_LanhdaoLienQuan({this.lstnguoidung});
  @override
  _MyComBo_LanhdaoLienQuan createState() => new _MyComBo_LanhdaoLienQuan();
}

List<int> lstlanhdaolienquan = new List<int>();

class _MyComBo_LanhdaoLienQuan extends State<MyComBo_LanhdaoLienQuan> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsldlq = [];
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
            if (list.lstlanhdaokhac.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.lstlanhdaokhac.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list.lstlanhdaokhac[i].tenhienthi),
                  value: list.lstlanhdaokhac[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsldlq,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn lãnh đạo"),
                ),
                searchHint: "Chọn lãnh đạo",
                onChanged: (value) {
                  lstlanhdaolienquan = new List<int>();
                  setState(() {
                    selectedItemsldlq = value;
                    selectedItemsldlq.forEach((element) {
                      lstlanhdaolienquan.add(int.parse(lst[element].value));
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
