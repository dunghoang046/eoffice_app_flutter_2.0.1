import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/NguoiDungThucHienCongViecItem.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NguoiDungTheoDoi extends StatefulWidget {
  Future<NguoiDungThucHienCongViecItem> lstobj;
  MyComBo_NguoiDungTheoDoi({this.lstobj});
  @override
  _MyComBo_NguoiDungTheoDoi createState() => new _MyComBo_NguoiDungTheoDoi();
}

List<int> lstnguoidungtheodoi = new List<int>();

class _MyComBo_NguoiDungTheoDoi extends State<MyComBo_NguoiDungTheoDoi> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsndtd = [];
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
                    list.obj.ltsUserFollow != null &&
                    list.obj.ltsUserFollow.length > 0)
                ? list.obj.ltsUserFollow.map((e) => e.id).toList()
                : new List<int>();
            if (list.lstnguoidung.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.lstnguoidung.length; i++) {
                if (lstitemselect.contains(list.lstnguoidung[i].id))
                  selectedItemsndtd.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(list.lstnguoidung[i].tenhienthi),
                  value: list.lstnguoidung[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsndtd,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người theo doi"),
                ),
                searchHint: "Chọn người theo dõi",
                onChanged: (value) {
                  lstnguoidungtheodoi = new List<int>();
                  setState(() {
                    selectedItemsndtd = value;
                    selectedItemsndtd.forEach((element) {
                      lstnguoidungtheodoi.add(int.parse(lst[element].value));
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
