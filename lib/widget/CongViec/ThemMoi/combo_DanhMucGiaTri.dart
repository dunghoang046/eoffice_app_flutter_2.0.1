import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DanhMucTenItem.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class MyComBo_DanhmucGiaTri extends StatefulWidget {
  final List<DanhMucTenItem> lstdm;
  MyComBo_DanhmucGiaTri({this.lstdm});
  _MyComBo_DanhmucGiaTri createState() => new _MyComBo_DanhmucGiaTri();
}

String lanhdaotrinhid;

class _MyComBo_DanhmucGiaTri extends State<MyComBo_DanhmucGiaTri> {
  @override
  Widget build(BuildContext context) {
    return combo();
  }

  // ignore: must_call_super
  void initState() {
    this.initState();
    loaddata();
  }

  List<DanhMucTenItem> listdm = [];
  loaddata() {
    listdm = widget.lstdm;
  }

  List<DropdownMenuItem> getdr(DanhMucTenItem item) {
    List<DropdownMenuItem> lstdm = [];
    for (var j = 0; j < item.lstdanhmucgt.length; j++) {
      lstdm.add(DropdownMenuItem(
        child: Text(item.lstdanhmucgt[j].tenDanhMuc),
        value: item.lstdanhmucgt[j].id.toString(),
      ));
    }
    return lstdm;
  }

  Widget combo() => Center(
          child: Column(
              children: List.generate(listdm.length, (index) {
        return Center(
          child: Column(
            children: [
              rowlabel(listdm[index].ten),
              SearchableDropdown.single(
                items: getdr(listdm[index]),
                value: lanhdaotrinhid,
                hint: "Chọn danh mục",
                searchHint: null,
                onChanged: (value) {
                  setState(() {
                    lanhdaotrinhid = value;
                  });
                },
                dialogBox: false,
                isExpanded: true,
                menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
              )
            ],
          ),
        );
      })));
}
