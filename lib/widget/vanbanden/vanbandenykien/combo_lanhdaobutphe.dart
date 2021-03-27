import 'package:flutter/material.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_chitiet.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_Lanhdaobutphe extends StatefulWidget {
  @override
  _MyComBo_Lanhdaobutphe createState() => new _MyComBo_Lanhdaobutphe();
}

var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};
List<int> ltsLanhDao = <int>[];

class _MyComBo_Lanhdaobutphe extends State<MyComBo_Lanhdaobutphe> {
  String strLanhDaoButPhe = '';

  NguoiDung_Api nndApi = new NguoiDung_Api();
  String _selectItem;
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  void onchangecombobox(String value) {
    setState(() {
      _selectItem = value;
    });
  }

  int selectedItemsldbp;
  Widget combo(dataquery) => Center(
          child: FutureBuilder(
        future: nndApi.getnguoidungbychucvu(dataquery),
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
              return SearchableDropdown.single(
                items: lst,
                value: selectedValue,
                hint: "Chọn lãnh đạo bút phê",
                searchHint: null,
                onChanged: (value) {
                  setState(() {
                    selectedValue = int.parse(value);
                  });
                },
                dialogBox: false,
                isExpanded: true,
                menuConstraints: BoxConstraints.tight(Size.fromHeight(350)),
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
  Widget contentlanhdaobutphe(dataquery) => Center(
          child: FutureBuilder(
        future: nndApi.getnguoidungbychucvu(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ðã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NguoiDungItem> list = snapshot.data;
            if (list.length > 0) {
              return DropdownButton(
                isExpanded: true,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  height: 1.5,
                ),
                items: list
                    .map((fc) => DropdownMenuItem<String>(
                          child: Text(fc.tenhienthi + ' - ' + fc.tenchucvu),
                          value: fc.id.toString(),
                        ))
                    .toList(),
                value: _selectItem,
                onChanged: onchangecombobox,
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
