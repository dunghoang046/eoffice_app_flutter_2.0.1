import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_Donvi extends StatefulWidget {
  @override
  _MyComBo_Donvi createState() => new _MyComBo_Donvi();
}

List<int> lstdonvi = new List<int>();

class _MyComBo_Donvi extends State<MyComBo_Donvi> {
  @override
  void initState() {
    lstdonvi = [];
    super.initState();
  }

  @override
  Vanbandi_api dvApi = new Vanbandi_api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemdv = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: dvApi.getdonvi(),
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
                selectedItems: selectedItemdv,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị"),
                ),
                searchHint: "Chọn đơn vị",
                onChanged: (value) {
                  setState(() {
                    lstdonvi = new List<int>();
                    selectedItemdv = value;
                    selectedItemdv.forEach((element) {
                      lstdonvi.add(int.parse(lst[element].value));
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
