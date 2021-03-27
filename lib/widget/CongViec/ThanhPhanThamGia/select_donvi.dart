import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/ModelForm/DonViThucHienCongViecItem.dart';
import 'package:app_eoffice/models/UserDonViItem.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

CongViec_Api objapi = new CongViec_Api();
List<int> selectedItemsdvtheodoi = [];
List<int> lstdonvitheodoi = <int>[];
List<int> selectedItemslstdvth = [];
List<int> lstdonvithuchien = <int>[];
Future<DonViThucHienCongViecItem> donvithuchien;
DonViThucHienCongViecItem donvithuchien_1;
Future<DonViThucHienCongViecItem> donvitheodoi;
List<DonViItem> lstdonviloading = <DonViItem>[];

class select_Donvi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Myselect_DonVi();
  }
}

class Myselect_DonVi extends StatefulWidget {
  Future<WorkTaskItem> objword;
  final id;
  Myselect_DonVi({this.objword, this.id});

  @override
  _Myselect_DonVi createState() => _Myselect_DonVi();
}

bool isloading = false;
bool isloadingtd = false;
DonViThucHienCongViecItem objnd = new DonViThucHienCongViecItem();
DonViThucHienCongViecItem objndtd = new DonViThucHienCongViecItem();

// ignore: camel_case_types
class _Myselect_DonVi extends State<Myselect_DonVi> {
  @override
  // ignore: must_call_super
  void initState() {
    isloading = false;
    isloadingtd = false;
    objnd = new DonViThucHienCongViecItem();
    objndtd = new DonViThucHienCongViecItem();
    selectedItemsdvtheodoi = [];
    selectedItemslstdvth = [];
    lstdonvithuchien = [];
    lstdonvitheodoi = [];
    var lst = Getlstdonvi();
    donvithuchien = getdonvi(lst);
    donvitheodoi = getdonvitd(lstdonvithuchien, lst);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          rowlabel('Đơn vị thực hiện'),
          combodonvithuchien(),
          rowlabel('Đơn vị theo dõi'),
          combodonvitheodoi()
        ],
      ),
    );
  }

  Future<List<DonViItem>> Getlstdonvi() async {
    var lstdonvi = await objapi.getdonvi();
    return lstdonvi;
  }

  Future<DonViThucHienCongViecItem> getdonvi(
      Future<List<DonViItem>> lstdonvi) async {
    if (objnd.lstdonvi == null) {
      objnd.obj = new WorkTaskItem();
      // objnd.lstdonvi = await objapi.getdonvi();
      objnd.lstdonvi = await lstdonvi;
    } else if (widget.id > 0) objnd.obj.ltsGroupPerform = <UserDonViItem>[];
    if (widget.id > 0) {
      var objcv = await widget.objword;
      if (objcv != null &&
          objcv.ltsGroupPerform != null &&
          objcv.ltsGroupPerform.length > 0) {
        objnd.obj.ltsGroupPerform = objcv.ltsGroupPerform.toList();
        lstdonvithuchien =
            objcv.ltsGroupPerform.map((e) => e.donviid).toSet().toList();
      }
    }
    return objnd;
  }

  Future<DonViThucHienCongViecItem> getdonvitd(
      List<int> lstth, Future<List<DonViItem>> lstdonvi) async {
    if (objndtd.lstdonvi == null) {
      objndtd.obj = new WorkTaskItem();
      objndtd.lstdonvi = await lstdonvi;
    } else if (widget.id > 0) objndtd.obj.ltsGroupFollow = <UserDonViItem>[];
    if (widget.id > 0) {
      var objcv = await widget.objword;
      if (objcv != null &&
          objcv.ltsGroupFollow != null &&
          objcv.ltsGroupFollow.length > 0) {
        objndtd.obj.ltsGroupFollow = objcv.ltsGroupFollow.toList();
        lstdonvitheodoi =
            objcv.ltsGroupFollow.map((e) => e.donviid).toSet().toList();
      }
      if (objcv != null &&
          objcv.ltsGroupPerform != null &&
          objcv.ltsGroupPerform.length > 0)
        lstth.addAll(objcv.ltsGroupPerform.map((e) => e.donviid));
    }
    if (lstth != null && lstth.length > 0)
      objndtd.lstdonvi =
          objndtd.lstdonvi.where((p) => !lstth.contains(p.id)).toList();
    return objndtd;
  }

  Future<DonViThucHienCongViecItem> getdonvithuchienchange(
      List<int> lstth, Future<List<DonViItem>> lstdonvi) async {
    objndtd.obj = new WorkTaskItem();
    objndtd.lstdonvi = await lstdonvi;

    if (lstth != null && lstth.length > 0)
      objndtd.lstdonvi =
          objndtd.lstdonvi.where((p) => !lstth.contains(p.id)).toList();
    return objndtd;
  }

  Widget combodonvithuchien() => Center(
          child: FutureBuilder(
        future: donvithuchien,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            DonViThucHienCongViecItem objdv = snapshot.data;
            var lstitemselect = (isloading != true &&
                    objdv.obj != null &&
                    objdv.obj.ltsGroupPerform != null &&
                    objdv.obj.ltsGroupPerform.length > 0)
                ? objdv.obj.ltsGroupPerform
                    .map((e) => e.donviid)
                    .toSet()
                    .toList()
                : <int>[];
            if (objdv.lstdonvi != null) {
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
                selectedItems: selectedItemslstdvth.toSet().toList(),
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị thực hiện"),
                ),
                searchHint: "Chọn đơn vị thực hiện",
                onChanged: (value) {
                  lstdonvithuchien = <int>[];
                  setState(() {
                    isloading = true;
                    selectedItemslstdvth = value;
                    selectedItemslstdvth.forEach((element) {
                      lstdonvithuchien.add(int.parse(lst[element].value));
                    });
                    lstdonvithuchien = lstdonvithuchien.toSet().toList();
                    lstdonvitheodoi = [];
                    selectedItemsdvtheodoi = [];
                    donvitheodoi =
                        getdonvithuchienchange(lstdonvithuchien, Getlstdonvi());
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
  Widget combodonvitheodoi() => Center(
          child: FutureBuilder(
        future: donvitheodoi,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            DonViThucHienCongViecItem objdv = snapshot.data;
            var lstitemselect = (isloadingtd != true &&
                    isloading != true &&
                    objdv.obj != null &&
                    objdv.obj.ltsGroupFollow != null &&
                    objdv.obj.ltsGroupFollow.length > 0)
                ? objdv.obj.ltsGroupFollow.map((e) => e.donviid).toList()
                : <int>[];
            if (objdv.lstdonvi != null) {
              List<DropdownMenuItem> lst = [];
              if (objdv.lstdonvi != null)
                for (var i = 0; i < objdv.lstdonvi.length; i++) {
                  if (lstitemselect.contains(objdv.lstdonvi[i].id))
                    selectedItemsdvtheodoi.add(i);
                  lst.add(DropdownMenuItem(
                    child: Text(objdv.lstdonvi[i].ten),
                    value: objdv.lstdonvi[i].id.toString(),
                  ));
                }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsdvtheodoi.toSet().toList(),
                // selectedItems: lstdonvitheodoi,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị theo dõi"),
                ),
                searchHint: "Chọn đơn vị theo dõi",
                onChanged: (value) {
                  lstdonvitheodoi = <int>[];
                  setState(() {
                    isloadingtd = true;
                    selectedItemsdvtheodoi = value;
                    selectedItemsdvtheodoi.forEach((element) {
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
