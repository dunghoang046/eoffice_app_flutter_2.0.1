import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/NhomNguoiDungThucHienCongViecItem.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';

import '../../Base_widget.dart';
import 'combo_nhomnguoithuchien.dart';

// ignore: camel_case_types
class MyComBo_NhomNguoiTheoDoi extends StatefulWidget {
  Future<NhomNguoiDungThucHienCongViecItem> objnhomnguoitd;
  Future<NhomNguoiDungThucHienCongViecItem> loadrefresh;
  MyComBo_NhomNguoiTheoDoi({this.objnhomnguoitd, @required this.loadrefresh});

  @override
  _MyComBo_NhomNguoiTheoDoi createState() => new _MyComBo_NhomNguoiTheoDoi();
}

List<int> lstnhomnguoitheodoi = new List<int>();

// ignore: camel_case_types
class _MyComBo_NhomNguoiTheoDoi extends State<MyComBo_NhomNguoiTheoDoi> {
  // ignore: must_call_super
  void initState() {
    setState(() {
      // ignore: unnecessary_statements
      widget.loadrefresh;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {
      // ignore: unnecessary_statements
      // widget.objnhomnguoitd = getnhomnguoidungtd(lstnhomnguoithuchien);
    });
    return combo();
  }

  Future<NhomNguoiDungThucHienCongViecItem> getnhomnguoidungtd(
      List<int> lstth) async {
    // var dataquery = {"ID": '' + widget.id.toString() + ''};
    NhomNguoiDungThucHienCongViecItem objnd =
        new NhomNguoiDungThucHienCongViecItem();
    objnd.lstnhomnguoidung = await objapi.getnhomnguoidung();
    objnd.lstnhomnguoidung =
        objnd.lstnhomnguoidung.where((p) => !lstth.contains(p.id)).toList();
    // if (widget.id > 0)
    //   objnd.obj = await objapi.getbyId(dataquery);
    // else
    objnd.obj = new WorkTaskItem();
    return objnd;
  }

  List<int> selectedItemsnntd = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: lstntd,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            NhomNguoiDungThucHienCongViecItem objnnd = snapshot.data;
            var lstitemselect = (objnnd.obj != null &&
                    objnnd.obj.ltsUserGroupFollow != null &&
                    objnnd.obj.ltsUserGroupFollow.length > 0)
                ? objnnd.obj.ltsUserGroupFollow.map((e) => e.id).toList()
                : new List<int>();
            if (objnnd.lstnhomnguoidung.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < objnnd.lstnhomnguoidung.length; i++) {
                if (lstitemselect.contains(objnnd.lstnhomnguoidung[i].id))
                  selectedItemsnntd.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(objnnd.lstnhomnguoidung[i].ten),
                  value: objnnd.lstnhomnguoidung[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsnntd,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người thực hiện"),
                ),
                searchHint: "Chọn nhóm người thực hiện",
                onChanged: (value) {
                  lstnhomnguoitheodoi = new List<int>();
                  setState(() {
                    selectedItemsnntd = value;
                    selectedItemsnntd.forEach((element) {
                      lstnhomnguoitheodoi.add(int.parse(lst[element].value));
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
