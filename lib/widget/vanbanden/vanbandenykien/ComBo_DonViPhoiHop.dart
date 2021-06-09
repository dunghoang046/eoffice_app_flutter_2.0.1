import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../../Base_widget.dart';

class MyComBo_DonViPhoiHop extends StatefulWidget {
  @override
  _MyComBo_DonViPhoiHop createState() => new _MyComBo_DonViPhoiHop();
}

var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};
List<int> lstDonViPhoiHop = new List<int>();

class _MyComBo_DonViPhoiHop extends State<MyComBo_DonViPhoiHop> {
  String strDonViPhoiHop = '';
  @override
  void initState() {
    lstDonViPhoiHop = [];
    super.initState();
  }

  @override
  DonVi_Api dvApi = new DonVi_Api();
  Widget build(BuildContext context) {
    // TODO: implement build
    return combo(dataquery);
  }

  List<int> selectedItemsdvph = [];
  Widget combo(dataquery) => Center(
          child: FutureBuilder(
        future: dvApi.getdonvi(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<DonViItem> list = snapshot.data;
            if (list.length > 0) {
              List<DropdownMenuItem> lst = [];
              for (var i = 0; i < list.length; i++) {
                lst.add(DropdownMenuItem(
                  child: Text(list[i].ten),
                  value: list[i].id.toString(),
                ));
              }
              return SearchableDropdown.multiple(
                items: lst,
                selectedItems: selectedItemsdvph,
                hint: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Chọn đơn vị"),
                ),
                searchHint: "Chọn đơn vị",
                onChanged: (value) {
                  setState(() {
                    lstDonViPhoiHop = new List<int>();
                    strDonViPhoiHop = '';
                    selectedItemsdvph = value;
                    selectedItemsdvph.forEach((element) {
                      lstDonViPhoiHop.add(int.parse(lst[element].value));
                      strDonViPhoiHop += ',' + lst[element].value.toString();
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
  Widget donvi(dataquery) => Center(
          child: FutureBuilder(
        future: dvApi.getdonvi(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<DonViItem> list = snapshot.data;
            if (list.length > 0) {
              var lst = [];
              for (var i = 0; i < list.length; i++) {
                var obj = {
                  'ten': '' + list[i].ten + '',
                  'id': '' + list[i].id.toString() + ''
                };
                lst.add(obj);
              }
              return MultiSelect(
                autovalidate: false,
                titleText: 'Chọn đơn vị',
                validator: (value) {
                  // if (value == null) {
                  //   return 'Chọn lãnh đạo';
                  // }
                },
                // errorText: 'Chọn lãnh đạo',
                dataSource: lst,
                textField: 'ten',
                valueField: 'id',
                // filterable: true,
                // required: true,
                value: null,
                onSaved: (value) {
                  print('The value is $value');
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
