import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class UpdateTrangThai extends StatefulWidget {
  @override
  _UpdateTrangThai createState() => new _UpdateTrangThai();
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  titleStyle: TextStyle(color: Colors.red, fontSize: 14),
);
List<DropdownMenuItem> lst = [];

class _UpdateTrangThai extends State<UpdateTrangThai> {
  void initState() {
    super.initState();
    lst.add(DropdownMenuItem(
      child: Text("Chưa xử lý"),
      value: 0,
    ));
    lst.add(DropdownMenuItem(
      child: Text("Đang xử lý"),
      value: 1,
    ));
    lst.add(DropdownMenuItem(
      child: Text("Đã xử lý"),
      value: 3,
    ));
  }

  int selectedValue;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text(''),
    );
  }
}

class NgayXuLyDateField extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        // controller: _hanxuly,
        decoration: InputDecoration(
            hintText: "H?n x? lý",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: Colors.black, width: 5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[200],
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.grey[200],
              ),
            ),
            labelText: 'H?n x? lý'),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
            // confirmText: 'Ch?n',
            // cancelText: 'H?y'
          );
        },
      ),
    ]);
  }
}
