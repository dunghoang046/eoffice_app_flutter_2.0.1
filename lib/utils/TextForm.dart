import 'package:flutter/material.dart';

class MyTextForm extends StatefulWidget {
  final String text_hind;
  final TextEditingController noidung;
  final isvalidate;
  MyTextForm({this.text_hind, this.noidung, this.isvalidate});

  @override
  _MyTextForm createState() => new _MyTextForm();
}

class _MyTextForm extends State<MyTextForm> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      maxLines: 2,
      controller: widget.noidung,

      // ignore: missing_return
      validator: (value) {
        if (widget.isvalidate) if (value.isEmpty)
          return 'Vui lòng nhập dữ liệu';
      },
      decoration: InputDecoration(
          hintText: widget.text_hind,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            borderSide: new BorderSide(color: Colors.black, width: 5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.grey[200],
            ),
          ),
          labelText: widget.text_hind),
    );
  }
}
