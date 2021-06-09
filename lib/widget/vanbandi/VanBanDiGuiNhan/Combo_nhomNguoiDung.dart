import 'package:flutter/material.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NhomNguoiDung extends StatefulWidget {
  @override
  _MyComBo_NhomNguoiDung createState() => new _MyComBo_NhomNguoiDung();
}

List<int> lstnhomnguoidung = <int>[];

class _MyComBo_NhomNguoiDung extends State<MyComBo_NhomNguoiDung> {
  @override
  void initState() {
    lstnhomnguoidung = [];
    super.initState();
  }

  @override
  Vanbandi_api dvApi = new Vanbandi_api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemndv = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: dvApi.getnhomnguoidung(),
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
                selectedItems: selectedItemndv,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người dùng"),
                ),
                searchHint: "Chọn nhóm người dùng",
                onChanged: (value) {
                  setState(() {
                    lstnhomnguoidung = new List<int>();
                    selectedItemndv = value;
                    selectedItemndv.forEach((element) {
                      lstnhomnguoidung.add(int.parse(lst[element].value));
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
