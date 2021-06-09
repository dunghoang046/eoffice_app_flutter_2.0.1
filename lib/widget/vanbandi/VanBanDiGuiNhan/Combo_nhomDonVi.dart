import 'package:flutter/material.dart';
import 'package:app_eoffice/models/NhomDonViItem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NhomDonVi extends StatefulWidget {
  @override
  _MyComBo_NhomDonVi createState() => new _MyComBo_NhomDonVi();
}

List<int> lstnhomdonvi = new List<int>();

class _MyComBo_NhomDonVi extends State<MyComBo_NhomDonVi> {
  @override
  void initState() {
    lstnhomdonvi = [];
    super.initState();
  }
  @override
  Vanbandi_api dvApi = new Vanbandi_api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsndv = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: dvApi.getnhomdonvi(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NhomDonViItem> list = snapshot.data;
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
                selectedItems: selectedItemsndv,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm đơn vị"),
                ),
                searchHint: "Chọn nhóm đơn vị",
                onChanged: (value) {
                  setState(() {
                    lstnhomdonvi = new List<int>();
                    selectedItemsndv = value;
                    selectedItemsndv.forEach((element) {
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
