import 'package:flutter/material.dart';
import 'package:app_eoffice/models/ModelForm/NhomNguoiDungThucHienCongViecItem.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';

// ignore: camel_case_types
class MyComBo_NhomNguoiThucHien extends StatefulWidget {
  Future<NhomNguoiDungThucHienCongViecItem> objnhomnguoith;
  MyComBo_NhomNguoiThucHien({this.objnhomnguoith});
  @override
  _MyComBo_NhomNguoiThucHien createState() => new _MyComBo_NhomNguoiThucHien();
}

CongViec_Api objapi = new CongViec_Api();
// List<int> lstnhomnguoithuchien = new List<int>();
Future<NhomNguoiDungThucHienCongViecItem> lstntd;
NhomNguoiDungThucHienCongViecItem lstntdxxx;

// ignore: camel_case_types
class _MyComBo_NhomNguoiThucHien extends State<MyComBo_NhomNguoiThucHien> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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

  List<int> selectedItemsnnd = [];
  Widget combo() => Center(
          child: FutureBuilder(
        future: widget.objnhomnguoith,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            NhomNguoiDungThucHienCongViecItem objnnth = snapshot.data;
            var lstitemselect = (objnnth.obj != null &&
                    objnnth.obj.ltsUserGroupPerform != null &&
                    objnnth.obj.ltsUserGroupPerform.length > 0)
                ? objnnth.obj.ltsUserGroupPerform.map((e) => e.id).toList()
                : <int>[];
            if (objnnth.lstnhomnguoidung.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < objnnth.lstnhomnguoidung.length; i++) {
                if (lstitemselect.length > 0 &&
                    lstitemselect.contains(objnnth.lstnhomnguoidung[i].id))
                  selectedItemsnnd.add(i);
                lst.add(DropdownMenuItem(
                  child: Text(objnnth.lstnhomnguoidung[i].ten),
                  value: objnnth.lstnhomnguoidung[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsnnd,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người thực hiện"),
                ),
                searchHint: "Chọn nhóm người thực hiện",
                // onChanged: (value) {
                //   lstnhomnguoithuchien = new List<int>();
                //   setState(() {
                //     selectedItemsnnd = value;
                //     selectedItemsnnd.forEach((element) {
                //       lstnhomnguoithuchien.add(int.parse(lst[element].value));
                //       lstntd = getnhomnguoidungtd(lstnhomnguoithuchien);
                //     });
                //   });
                // },
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
