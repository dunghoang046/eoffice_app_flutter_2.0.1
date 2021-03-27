import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/DonViThucHienCongViecItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

class MyComBo_DonViTheoDoi extends StatefulWidget {
  Future<DonViThucHienCongViecItem> lstdonvith;
  MyComBo_DonViTheoDoi({this.lstdonvith});
  @override
  _MyComBo_DonViTheoDoi createState() => new _MyComBo_DonViTheoDoi();
}

List<int> lstdonvitheodoi = new List<int>();

class _MyComBo_DonViTheoDoi extends State<MyComBo_DonViTheoDoi> {
  CongViec_Api nndApi = new CongViec_Api();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo();
  }

  List<int> selectedItemsdvtd = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: widget.lstdonvith,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            DonViThucHienCongViecItem objdv = snapshot.data;
            var lstitemselect = (objdv.obj != null &&
                    objdv.obj.ltsGroupPerform != null &&
                    objdv.obj.ltsGroupPerform.length > 0)
                ? objdv.obj.ltsGroupPerform.map((e) => e.id).toList()
                : new List<int>();
            if (objdv.lstdonvi.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < objdv.lstdonvi.length; i++) {
                if (lstitemselect.contains(objdv.lstdonvi[i].id))
                  selectedItemsdvtd.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(objdv.lstdonvi[i].ten),
                  value: objdv.lstdonvi[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsdvtd,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị theo dõi"),
                ),
                searchHint: "Chọn đơn vị theo dõi",
                onChanged: (value) {
                  lstdonvitheodoi = new List<int>();
                  setState(() {
                    selectedItemsdvtd = value;
                    selectedItemsdvtd.forEach((element) {
                      lstdonvitheodoi.add(int.parse(lst[element].value));
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
