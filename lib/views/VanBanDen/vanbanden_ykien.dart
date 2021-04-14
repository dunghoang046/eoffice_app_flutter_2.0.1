import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDenYkienItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_formykien.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/vanbanden/ViewYkenVBDen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';

class MyVanBanDenYKien extends StatefulWidget {
  final int id;
  MyVanBanDenYKien({@required this.id});
  @override
  _MyVanBanDenYKien createState() => new _MyVanBanDenYKien();
}

Vanbanden_api objApi = new Vanbanden_api();

Future<List<VanBanDenYKienItem>> lstykien;

class _MyVanBanDenYKien extends State<MyVanBanDenYKien> {
  Vanbanden_api objapi = new Vanbanden_api();
  @override
  void initState() {
    loadykien();
    super.initState();
  }

  void loadykien() {
    var dataquery = {"VanBanID": '' + widget.id.toString() + '', "lang": 'vi'};
    lstykien = objapi.getykienvanbanden(dataquery);
  }

  Widget contentbody(dataquery) => Center(
          child: FutureBuilder(
        future: lstykien,
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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Ý kiến văn bản đến',
          style: TextStyle(color: Colors.white),
        ),
        leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              SimpleRouter.back();
            }),
        backgroundColor: colorbartop,
      ),
      body: BlocBuilder<BlocVanBanDenAction, ActionState>(
          buildWhen: (pre, state) {
        if (state is ViewYKienState) {
          loadykien();
        }
        return;
      }, builder: (context, state) {
        return contentbody(dataquery);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SimpleRouter.forward(MyVanBanDenYKienForm(id: widget.id));
        },
        child: Icon(Icons.add_comment),
      ),
    ));
  }
}
