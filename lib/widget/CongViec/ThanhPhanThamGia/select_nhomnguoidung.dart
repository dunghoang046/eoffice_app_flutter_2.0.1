import 'package:app_eoffice/models/ModelForm/NhomNguoiDungThucHienCongViecItem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

CongViec_Api objapi = new CongViec_Api();
List<int> selectedItemsnnd = [];
List<int> lstnhomnguoithuchien = <int>[];
Future<NhomNguoiDungThucHienCongViecItem> nhomnguoitheodoi;
Future<NhomNguoiDungThucHienCongViecItem> nhomnguoithuchien;
List<int> selectedItemsnntd = [];
List<int> lstnhomnguoitheodoi = <int>[];
bool isloading = false;
bool isloadingtd = false;

// ignore: must_be_immutable
class Myselect_NhomNguoiDung extends StatefulWidget {
  Future<WorkTaskItem> objword;
  final id;
  Myselect_NhomNguoiDung(this.objword, this.id);
  @override
  _Myselect_NhomNguoiDung createState() => _Myselect_NhomNguoiDung();
}

// ignore: camel_case_types
class _Myselect_NhomNguoiDung extends State<Myselect_NhomNguoiDung> {
  void initState() {
    selectedItemsnnd = [];
    selectedItemsnntd = [];
    isloading = false;
    isloadingtd = false;
    var lst = getnhomnguoidung();
    nhomnguoithuchien = getnhomnguoidungth(lst);
    nhomnguoitheodoi = getnhomnguoidungtheodoi(lst, lstnhomnguoithuchien);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          rowlabel('Nhóm người thực hiện'),
          combonhomnguoithuchien(),
          rowlabel('Nhóm người theo dõi'),
          combonhomnguoitheodoi(),
        ],
      ),
    );
  }

  Future<List<NhomNguoiDungItem>> getnhomnguoidung() async {
    var lstnhomnd = await objapi.getnhomnguoidung();
    return lstnhomnd;
  }

  Future<NhomNguoiDungThucHienCongViecItem> getnhomnguoidungth(
      Future<List<NhomNguoiDungItem>> lst) async {
    NhomNguoiDungThucHienCongViecItem objnd =
        new NhomNguoiDungThucHienCongViecItem();
    objnd.obj = new WorkTaskItem();
    objnd.lstnhomnguoidung = await lst;
    if (widget.id > 0) {
      var objcv = await widget.objword;
      if (objcv != null &&
          objcv.ltsUserGroupPerform != null &&
          objcv.ltsUserGroupPerform.length > 0) {
        objnd.obj.ltsUserGroupPerform = objcv.ltsUserGroupPerform.toList();
        lstnhomnguoithuchien =
            objcv.ltsUserGroupPerform.map((e) => e.nhomid).toSet().toList();
      }
    }
    return objnd;
  }

  Future<NhomNguoiDungThucHienCongViecItem> getnhomnguoidungtheodoi(
      Future<List<NhomNguoiDungItem>> lst, List<int> lstth) async {
    NhomNguoiDungThucHienCongViecItem objnd =
        new NhomNguoiDungThucHienCongViecItem();
    objnd.lstnhomnguoidung = await lst;
    objnd.obj = new WorkTaskItem();

    if (widget.id > 0) {
      var objcv = await widget.objword;
      if (objcv != null &&
          objcv.ltsUserGroupFollow != null &&
          objcv.ltsUserGroupFollow.length > 0) {
        objnd.obj.ltsUserGroupFollow = objcv.ltsUserGroupFollow.toList();
        lstnhomnguoitheodoi =
            objcv.ltsUserGroupFollow.map((e) => e.nhomid).toSet().toList();
      }
      if (objcv != null &&
          objcv.ltsUserGroupPerform != null &&
          objcv.ltsUserGroupPerform.length > 0)
        lstth.addAll(objcv.ltsUserGroupPerform.map((e) => e.nhomid));
    }
    if (lstth.length > 0)
      objnd.lstnhomnguoidung =
          objnd.lstnhomnguoidung.where((p) => !lstth.contains(p.id)).toList();
    return objnd;
  }

  Future<NhomNguoiDungThucHienCongViecItem> getnhomnguoidungthuchienchange(
      List<NhomNguoiDungItem> lst, List<int> lstth) async {
    NhomNguoiDungThucHienCongViecItem objnd =
        new NhomNguoiDungThucHienCongViecItem();
    objnd.lstnhomnguoidung = lst;
    objnd.obj = new WorkTaskItem();
    if (lstth.length > 0)
      objnd.lstnhomnguoidung =
          objnd.lstnhomnguoidung.where((p) => !lstth.contains(p.id)).toList();
    return objnd;
  }

  Widget combonhomnguoithuchien() => Center(
          child: FutureBuilder(
        future: nhomnguoithuchien,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            NhomNguoiDungThucHienCongViecItem objnnth = snapshot.data;
            var lstitemselect = (isloading != true &&
                    objnnth.obj != null &&
                    objnnth.obj.ltsUserGroupPerform != null &&
                    objnnth.obj.ltsUserGroupPerform.length > 0)
                ? objnnth.obj.ltsUserGroupPerform
                    .map((e) => e.nhomid)
                    .toSet()
                    .toList()
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
                selectedItems: selectedItemsnnd.toSet().toList(),
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người thực hiện"),
                ),
                searchHint: "Chọn nhóm người thực hiện",
                onChanged: (value) {
                  lstnhomnguoithuchien = <int>[];
                  setState(() {
                    selectedItemsnnd = value;
                    selectedItemsnnd.forEach((element) {
                      lstnhomnguoithuchien.add(int.parse(lst[element].value));
                    });
                    isloading = true;
                    selectedItemsnntd = [];
                    lstnhomnguoitheodoi = [];
                    nhomnguoitheodoi = getnhomnguoidungthuchienchange(
                        objnnth.lstnhomnguoidung, lstnhomnguoithuchien);
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
  Widget combonhomnguoitheodoi() => Center(
          child: FutureBuilder(
        future: nhomnguoitheodoi,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            NhomNguoiDungThucHienCongViecItem objnnd = snapshot.data;
            var lstitemselect = (isloading != true &&
                    !isloadingtd &&
                    objnnd.obj != null &&
                    objnnd.obj.ltsUserGroupFollow != null &&
                    objnnd.obj.ltsUserGroupFollow.length > 0)
                ? objnnd.obj.ltsUserGroupFollow
                    .map((e) => e.nhomid)
                    .toSet()
                    .toList()
                : <int>[];
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
                selectedItems: selectedItemsnntd.toSet().toList(),
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn nhóm người thực hiện"),
                ),
                searchHint: "Chọn nhóm người thực hiện",
                onChanged: (value) {
                  lstnhomnguoitheodoi = <int>[];
                  setState(() {
                    isloadingtd = true;
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
