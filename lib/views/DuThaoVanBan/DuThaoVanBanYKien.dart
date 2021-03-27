import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDiYKienItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanYKienItemList.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_FormYKien.dart';

class MyDuThaoVanBanYKien extends StatefulWidget {
  final int id;
  MyDuThaoVanBanYKien({@required this.id});
  @override
  _MyDuThaoVanBanYKien createState() => new _MyDuThaoVanBanYKien();
}

class _MyDuThaoVanBanYKien extends State<MyDuThaoVanBanYKien> {
  DuThaoVanBan_api objapi = new DuThaoVanBan_api();
  @override
  void initState() {
    super.initState();
  }

  Widget contentbody(dataquery) => Center(
          child: FutureBuilder(
        future: objapi.getykienbyvanban(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<VanBanDiYKienItem> list = snapshot.data;
            if (list.length > 0)
              return DuThaoVanBanYkienItemList(lstobj: list);
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
          'Ý kiến',
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
                builder: (context) => MyDuThaoVanBanYKienForm(id: widget.id)),
          );
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
