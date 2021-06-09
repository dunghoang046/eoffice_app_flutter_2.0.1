import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_NguoiXuLy extends StatefulWidget {
  @override
  _MyComBo_NguoiXuLy createState() => new _MyComBo_NguoiXuLy();
}

var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};
List<int> lstNguoiDauMoi = new List<int>();

class _MyComBo_NguoiXuLy extends State<MyComBo_NguoiXuLy> {
  void initState() {
    super.initState();
    lstNguoiDauMoi = [];
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  List<int> selectedItemsnxl = [];

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
                selectedItems: selectedItemsnxl,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn người xử lý"),
                ),
                searchHint: "Chọn người xử lý",
                onChanged: (value) {
                  lstNguoiDauMoi = new List<int>();
                  setState(() {
                    selectedItemsnxl = value;
                    selectedItemsnxl.forEach((element) {
                      lstNguoiDauMoi.add(int.parse(lst[element].value));
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
  Widget nguoixuly(dataquery) => Center(
          child: FutureBuilder(
        future: nndApi.getnguoidungbydonvi(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ðã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<NguoiDungItem> list = snapshot.data;
            if (list.length > 0) {
              var lst = [];
              for (var i = 0; i < list.length; i++) {
                var obj = {
                  'tenhienthi': '' + list[i].tenhienthi + '',
                  'id': '' + list[i].id.toString() + ''
                };
                lst.add(obj);
              }
              return MultiSelect(
                autovalidate: false,
                titleText: 'Chọn người dùng',
                validator: (value) {
                  // if (value == null) {
                  //   return 'Ch?n lãnh d?o';
                  // }
                },
                // errorText: 'Ch?n lãnh d?o',
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
                  print(values);
                },
                titleTextColor: Colors.grey,
                buttonBarColor: Colors.white,
                selectIconColor: Colors.white,
                selectedOptionsInfoTextColor: Colors.blue,
                deleteButtonTooltipText: 'll',
                hintTextColor: Colors.blue,
                selectedOptionsBoxColor: Colors.grey,
                selectedOptionsInfoText: 'Người dùng đã chọn',
                // selectIcon: Icons.arrow_drop_down_circle,
                saveButtonColor: Colors.blue,
                checkBoxColor: Colors.blue,
                cancelButtonColor: Colors.red,
                cancelButtonTextColor: Colors.white,
                cancelButtonText: 'Hủy',
                searchBoxToolTipText: 'Nhập từ khóa tìm kiếm',
                saveButtonText: 'Ðang ý',
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
