import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDenYkienItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_chitiet.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_formykien.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/vanbanden/ViewYkenVBDen.dart';
import 'package:simple_router/simple_router.dart';

class MyVanBanDenYKien extends StatefulWidget {
  final int id;
  MyVanBanDenYKien({@required this.id});
  @override
  _MyVanBanDenYKien createState() => new _MyVanBanDenYKien();
}

Vanbanden_api objApi = new Vanbanden_api();

class _MyVanBanDenYKien extends State<MyVanBanDenYKien> {
  Vanbanden_api objapi = new Vanbanden_api();
  @override
  void initState() {
    super.initState();
  }

  Widget contentbody(dataquery) => Center(
          child: FutureBuilder(
        future: objapi.getykienvanbanden(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<VanBanDenYKienItem> list = snapshot.data;
            if (list.length > 0)
              return VanBanDenYKienItemList(lstobj: list);
            else
              return notrecord();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));

  Widget build(BuildContext context) {
    var dataquery = {"VanBanID": '' + widget.id.toString() + '', "lang": 'vi'};
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Ý kiến văn bản đến',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => MyVanVanDenChiTiet(id: widget.id)),
              // );
              SimpleRouter.back();
            }),
        backgroundColor: Color.fromARGB(255, 248, 144, 31),
      ),
      body: contentbody(dataquery),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showAlertDialog(context, 'Nội dung', 'Ý kiến xử lý', 'Đồng ý', 'Hủy',
          //     MyVanBanDenYKienForm());
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => MyVanBanDenYKienForm(id: widget.id)),
          // );
          SimpleRouter.forward(MyVanBanDenYKienForm(id: widget.id));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
