import 'package:flutter/material.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NguoiphoiHop extends StatefulWidget {
  @override
  _MyComBo_NguoiphoiHop createState() => new _MyComBo_NguoiphoiHop();
}

var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};
List<int> lstNguoiPhoiHop = new List<int>();

class _MyComBo_NguoiphoiHop extends State<MyComBo_NguoiphoiHop> {
  void initState() {
    lstNguoiPhoiHop = [];
    super.initState();
    if (nguoidungsessionView.vitriid != 3 &&
        !checkquyen(nguoidungsessionView.quyenhan, QuyenHan().VanthuDonvi) &&
        nguoidungsessionView.ltsphongbanid.length > 0) {
      dataquery = {
        "Chucvu": '2,3,4,6',
        "DonViID": '' + nguoidungsessionView.ltsphongbanid[0].toString() + ''
      };
    }
  }

  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  List<int> selectedItemsnph = [];
  Widget combo(dataquery) => Center(
          child: FutureBuilder(
        future: nndApi.getnguoidungbydonvi(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NguoiDungItem> list = snapshot.data;
            if (list.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list[i].tenhienthi),
                  value: list[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsnph,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người phối hợp"),
                ),
                searchHint: "Chọn người phối hợp",
                onChanged: (value) {
                  lstNguoiPhoiHop = new List<int>();
                  setState(() {
                    selectedItemsnph = value;
                    selectedItemsnph.forEach((element) {
                      lstNguoiPhoiHop.add(int.parse(lst[element].value));
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
