import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:app_eoffice/views/VanBanDi/VanBanDiGuiNhan/VanBanDi_formGuiNhan.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhanItemList.dart';

class MyVanBanDiGuiNhan extends StatefulWidget {
  final int id;
  MyVanBanDiGuiNhan({@required this.id});
  @override
  _MyVanBanDiGuiNhan createState() => new _MyVanBanDiGuiNhan();
}

Vanbanden_api objApi = new Vanbanden_api();

class _MyVanBanDiGuiNhan extends State<MyVanBanDiGuiNhan> {
  Vanbandi_api objapi = new Vanbandi_api();
  @override
  void initState() {
    super.initState();
  }

  Widget contentbody(dataquery) => Center(
          child: FutureBuilder(
        future: objapi.getvanbandiguinhan(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<VanBanDiGuiNhanItem> list = snapshot.data;
            if (list.length > 0)
              return VanBanDiGuiNhanItemList(lstobj: list);
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
          'Thông tin gửi nhận',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color.fromARGB(255, 248, 144, 31),
      ),
      body: contentbody(dataquery),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyVanBanDiGuiNhanForm(id: widget.id)),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
