import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NhomNguoiNhan extends StatefulWidget {
  @override
  _MyComBo_NhomNguoiNhan createState() => new _MyComBo_NhomNguoiNhan();
}

var dataquery = {"DonViID": '' + nguoidungsessionView.donviid.toString() + ''};
List<int> lstnhomnguoinhan = new List<int>();

class _MyComBo_NhomNguoiNhan extends State<MyComBo_NhomNguoiNhan> {
  @override
  void initState() {
    lstnhomnguoinhan = [];
    super.initState();
  }

  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  List<int> selectedItemsnhomnn = [];
  Widget combo(dataquery) => Center(
          child: FutureBuilder(
        future: dvApi.getnhomnguoidungbydonvi(dataquery),
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
                selectedItems: selectedItemsnhomnn,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người nhận"),
                ),
                searchHint: "Chọn nhóm người nhận",
                onChanged: (value) {
                  lstnhomnguoinhan = new List<int>();
                  setState(() {
                    selectedItemsnhomnn = value;
                    selectedItemsnhomnn.forEach((element) {
                      lstnhomnguoinhan.add(int.parse(lst[element].value));
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
