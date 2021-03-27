import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/NguoiDungThucHienCongViecItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NguoiDungThucHien extends StatefulWidget {
  Future<NguoiDungThucHienCongViecItem> lstobj;
  MyComBo_NguoiDungThucHien({this.lstobj});
  @override
  _MyComBo_NguoiDungThucHien createState() => new _MyComBo_NguoiDungThucHien();
}

List<int> lstnguoidungthuchien = new List<int>();

class _MyComBo_NguoiDungThucHien extends State<MyComBo_NguoiDungThucHien> {
  CongViec_Api nndApi = new CongViec_Api();
  @override
  void initState() {
    loaddata();
  }

  loaddata() async {}

  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsldlq = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: widget.lstobj,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            NguoiDungThucHienCongViecItem list = snapshot.data;
            var lstitemselect = (list.obj != null &&
                    list.obj.ltsUserPerform != null &&
                    list.obj.ltsUserPerform.length > 0)
                ? list.obj.ltsUserPerform.map((e) => e.id).toList()
                : new List<int>();
            if (list.lstnguoidung.length > 0) {
              List<DropdownMenuItem> lst = [];
              selectedItemsldlq = [];
              for (var i = 0; i < list.lstnguoidung.length; i++) {
                if (lstitemselect.contains(list.lstnguoidung[i].id))
                  selectedItemsldlq.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(list.lstnguoidung[i].tenhienthi),
                  value: list.lstnguoidung[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsldlq,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người thực hiện"),
                ),
                searchHint: "Chọn người thực hiện",
                onChanged: (value) {
                  lstnguoidungthuchien = new List<int>();
                  setState(() {
                    selectedItemsldlq = value;
                    selectedItemsldlq.forEach((element) {
                      lstnguoidungthuchien.add(int.parse(lst[element].value));
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
