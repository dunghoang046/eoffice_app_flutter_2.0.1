import 'package:flutter/material.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NguoiDung extends StatefulWidget {
  @override
  _MyComBo_NguoiDung createState() => new _MyComBo_NguoiDung();
}

List<int> lstnguoidung = new List<int>();

class _MyComBo_NguoiDung extends State<MyComBo_NguoiDung> {
  @override
  void initState() {
    lstnguoidung = [];
    super.initState();
  }

  @override
  Vanbandi_api dvApi = new Vanbandi_api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemnd = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: dvApi.getnguoidung(),
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
                selectedItems: selectedItemnd,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người dùng"),
                ),
                searchHint: "Chọn người dùng",
                onChanged: (value) {
                  setState(() {
                    lstnguoidung = new List<int>();
                    selectedItemnd = value;
                    selectedItemnd.forEach((element) {
                      lstnguoidung.add(int.parse(lst[element].value));
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
