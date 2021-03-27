import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/DonViThucHienCongViecItem.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_DonViThucHien extends StatefulWidget {
  Future<DonViThucHienCongViecItem> lstdonvith;
  MyComBo_DonViThucHien({this.lstdonvith});
  @override
  _MyComBo_DonViThucHien createState() => new _MyComBo_DonViThucHien();
}

List<int> lstdonvithuchien = new List<int>();

class _MyComBo_DonViThucHien extends State<MyComBo_DonViThucHien> {
  @override
  Widget build(BuildContext context) {
    return combo();
  }

  List<int> selectedItemslstdvth = [];
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
                    objdv.obj.ltsGroupFollow != null &&
                    objdv.obj.ltsGroupFollow.length > 0)
                ? objdv.obj.ltsGroupFollow.map((e) => e.id).toList()
                : new List<int>();
            if (objdv.lstdonvi.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < objdv.lstdonvi.length; i++) {
                if (lstitemselect.contains(objdv.lstdonvi[i].id))
                  selectedItemslstdvth.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(objdv.lstdonvi[i].ten),
                  value: objdv.lstdonvi[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemslstdvth,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị thực hiện"),
                ),
                searchHint: "Chọn đơn vị thực hiện",
                onChanged: (value) {
                  lstdonvithuchien = new List<int>();
                  setState(() {
                    selectedItemslstdvth = value;
                    selectedItemslstdvth.forEach((element) {
                      lstdonvithuchien.add(int.parse(lst[element].value));
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
