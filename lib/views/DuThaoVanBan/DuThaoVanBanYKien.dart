import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDiYKienItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanYKienItemList.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_FormYKien.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';

class MyDuThaoVanBanYKien extends StatefulWidget {
  final int id;
  MyDuThaoVanBanYKien({@required this.id});
  @override
  _MyDuThaoVanBanYKien createState() => new _MyDuThaoVanBanYKien();
}

Future<List<VanBanDiYKienItem>> lstykien;

class _MyDuThaoVanBanYKien extends State<MyDuThaoVanBanYKien> {
  DuThaoVanBan_api objapi = new DuThaoVanBan_api();
  @override
  void initState() {
    loadykien();
    super.initState();
  }

  void loadykien() {
    var dataquery = {"VanBanID": '' + widget.id.toString() + '', "lang": 'vi'};
    lstykien = objapi.getykienbyvanban(dataquery);
  }

  Widget contentbody() => Center(
          child: FutureBuilder(
        future: lstykien,
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
        backgroundColor: colorbartop,
      ),
      body: BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
          buildWhen: (previousState, state) {
        if (state is ViewYKienState) {
          loadykien();
        }
        return;
      }, builder: (context, state) {
        return contentbody();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SimpleRouter.forward(MyDuThaoVanBanYKienForm(id: widget.id));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
