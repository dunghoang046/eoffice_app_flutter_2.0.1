import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDi_View.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:app_eoffice/views/VanBanDi/VanBanDiGuiNhan/VanBanDiGuiNhan.dart';
import 'package:simple_router/simple_router.dart';

class MyVanVanDiChiTiet extends StatefulWidget {
  final int id;
  MyVanVanDiChiTiet({@required this.id});
  _MyVanVanDiChiTiet createState() => _MyVanVanDiChiTiet();
}

Future<VanBanDiItem> obj;
Vanbandi_api objapi = new Vanbandi_api();

class _MyVanVanDiChiTiet extends State<MyVanVanDiChiTiet> {
  // ignore: must_call_super
  void initState() {
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Chi tiết văn bản đi',
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
      // body: Text('dd'),
      floatingActionButton: buildSpeedDial(),
    );
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      obj = objapi.getbyId(dataquery);
    }
  }

  Widget contentbody(dataquery) => Container(
      margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: FutureBuilder(
        future: obj,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            VanBanDiItem list = snapshot.data;
            return ViewVanBanDiPanel(obj: list);
            // return Text('data');
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));

  SpeedDial buildSpeedDial() {
    return SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.sync, color: Colors.white),
            backgroundColor: Colors.deepOrange,
            onTap: () {
              SimpleRouter.forward(MyVanBanDiGuiNhan(id: widget.id));
            },
            label: 'Gửi nhận ',
            labelStyle:
                TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            labelBackgroundColor: Colors.deepOrangeAccent,
          ),
        ]);
  }
}
