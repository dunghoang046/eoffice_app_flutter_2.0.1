import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_Lanhdaotrinh extends StatefulWidget {
  @override
  _MyComBo_Lanhdaotrinh createState() => new _MyComBo_Lanhdaotrinh();
}

var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};
String strLanhDaoTrinh = '';
List<int> lstlanhdaotrinh = <int>[];

class _MyComBo_Lanhdaotrinh extends State<MyComBo_Lanhdaotrinh> {
  NguoiDung_Api nndApi = new NguoiDung_Api();
  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  List<int> selectedItemsldt = [];
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
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsldt,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn lãnh đạo"),
                ),
                searchHint: "Chọn lãnh đạo",
                onChanged: (value) {
                  lstlanhdaotrinh = new List<int>();
                  setState(() {
                    strLanhDaoTrinh = '';
                    selectedItemsldt = value;
                    selectedItemsldt.forEach((element) {
                      strLanhDaoTrinh += ',' + lst[element].value.toString();
                      lstlanhdaotrinh.add(int.parse(lst[element].value));
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
  Widget contentlanhdaobp(dataquery) => Center(
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
              var lst = [];

              for (var i = 0; i < list.length; i++) {
                var obj = {
                  'tenhienthi':
                      '' + list[i].tenhienthi + ' - ' + list[i].tenchucvu + '',
                  'id': '' + list[i].id.toString() + ''
                };

                lst.add(obj);
              }
              return MultiSelect(
                autovalidate: false,
                titleText: 'Chọn lãnh đạo',
                validator: (value) {
                  // if (value == null) {
                  //   return 'Chọn lãnh đạo';
                  // }
                },
                // errorText: 'Chọn lãnh đạo',
                dataSource: lst,
                textField: 'tenhienthi',
                valueField: 'id',
                // filterable: true,
                // required: true,
                value: null,
                onSaved: (value) {
                  print('The value is $value');
                },
                change: (values) {
                  print('The value is $values');
                },

                titleTextColor: Colors.grey,
                buttonBarColor: Colors.white,
                selectIconColor: Colors.white,
                selectedOptionsInfoTextColor: Colors.blue,
                hintTextColor: Colors.blue,
                selectedOptionsBoxColor: Colors.grey,
                selectedOptionsInfoText: 'Lãnh đạo đã chọn',
                // selectIcon: Icons.arrow_drop_down_circle,
                saveButtonColor: Colors.blue,
                checkBoxColor: Colors.blue,
                cancelButtonColor: Colors.red,
                cancelButtonTextColor: Colors.white,
                cancelButtonText: 'Hủy',
                searchBoxToolTipText: 'Nhập từ khóa tìm kiếm',
                saveButtonText: 'Đồng ý',
                searchBoxHintText: 'Tìm kiếm',
                hintText: '',
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
