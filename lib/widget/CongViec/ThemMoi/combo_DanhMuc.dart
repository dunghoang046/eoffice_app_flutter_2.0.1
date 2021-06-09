import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';
import 'package:app_eoffice/models/DanhMucTenItem.dart';
import 'package:app_eoffice/models/ModelForm/DanhMucCongViecItem.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../../Base_widget.dart';

class MyComBo_Danhmuc extends StatefulWidget {
  @override
  Future<DanhMucCongViecItem> lstdm;
  MyComBo_Danhmuc({this.lstdm});
  _MyComBo_Danhmuc createState() => new _MyComBo_Danhmuc();
}

String lanhdaotrinhid;
List<String> lstdanhmucgiatri = [];

class _MyComBo_Danhmuc extends State<MyComBo_Danhmuc> {
  // ignore: must_call_super
  void initState() {
    loaddata();
  }

  loaddata() async {
    var dm = await widget.lstdm;
    // ignore: deprecated_member_use
    if (dm != null && dm.lstdanhmuc != null)
      lstdanhmucgiatri = new List(dm.lstdanhmuc.length);
    var lstdmgtcv = <DanhMucGiaTriItem>[];
    if (dm != null && dm.obj != null) lstdmgtcv = dm.obj.lstdanhmucgt;
    for (var i = 0; i < dm.lstdanhmuc.length; i++) {
      lstdanhmucgiatri[i] = '0';
      if (lstdmgtcv != null && lstdmgtcv.length > 0)
        for (var j = 0; j < dm.lstdanhmuc[i].lstdanhmucgt.length; j++) {
          if (lstdmgtcv
              .map((e) => e.id)
              .contains(dm.lstdanhmuc[i].lstdanhmucgt[j].id))
            lstdanhmucgiatri[i] =
                dm.lstdanhmuc[i].lstdanhmucgt[j].id.toString();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return combo();
  }

  List<DropdownMenuItem> getdr(DanhMucTenItem item) {
    List<DropdownMenuItem> lstdm = [];
    if (item.lstdanhmucgt != null) {
      for (var j = 0; j < item.lstdanhmucgt.length; j++) {
        if (item.lstdanhmucgt[j] != null)
          lstdm.add(DropdownMenuItem(
            child: Text(item.lstdanhmucgt[j].ten),
            value: item.lstdanhmucgt[j].id.toString(),
          ));
      }
    }
    return lstdm;
  }

  Widget combo() => Center(
          child: FutureBuilder(
        future: widget.lstdm,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            DanhMucCongViecItem listdm = snapshot.data;
            if (listdm.lstdanhmuc.length > 0) {
              return Center(
                  child: Column(
                      children:
                          List.generate(listdm.lstdanhmuc.length, (index) {
                return Center(
                  child: Column(
                    children: [
                      rowlabel(listdm.lstdanhmuc[index].ten),
                      SearchableDropdown.single(
                        items: getdr(listdm.lstdanhmuc[index]),
                        value: lstdanhmucgiatri[index],
                        hint: "Chọn danh mục",
                        searchHint: null,
                        onChanged: (value) {
                          setState(() {
                            if (value == null)
                              lstdanhmucgiatri[index] = '0';
                            else
                              lstdanhmucgiatri[index] = value;
                          });
                        },
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints:
                            BoxConstraints.tight(Size.fromHeight(350)),
                      )
                    ],
                  ),
                );
              })));
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
