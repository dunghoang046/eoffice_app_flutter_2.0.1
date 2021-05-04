import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDenGuiNhanItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/vanbanden/VanBanDenGuiNhanItemList.dart';
import 'package:simple_router/simple_router.dart';

class MyVanBanDenGuNhan extends StatefulWidget {
  final int id;
  MyVanBanDenGuNhan({@required this.id});
  @override
  _MyVanBanDenGuNhan createState() => new _MyVanBanDenGuNhan();
}

Vanbanden_api objApi = new Vanbanden_api();

class _MyVanBanDenGuNhan extends State<MyVanBanDenGuNhan> {
  Vanbanden_api objapi = new Vanbanden_api();
  @override
  void initState() {
    super.initState();
  }

  Widget contentbody(dataquery) => Center(
          child: FutureBuilder(
        future: objapi.getvanbandenguinhan(dataquery),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<VanBanDenGuiNhanItem> list = snapshot.data;
            if (list.length > 0)
              return VanBanDenGUiNhanItemList(lstobj: list);
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
              SimpleRouter.back();
            }),
        backgroundColor: colorbartop,
      ),
      body: contentbody(dataquery),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => MyVanBanDenYKienForm(id: widget.id)),
      //     );
      //   },
      //   child: Icon(Icons.add_comment),
      // ),
    );
  }
}
