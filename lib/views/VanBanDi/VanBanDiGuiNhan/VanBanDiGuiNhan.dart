import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:app_eoffice/views/VanBanDi/VanBanDiGuiNhan/VanBanDi_formGuiNhan.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhanItemList.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';

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
    BlocProvider.of<BlocVanBanDiAction>(context).add(NoEven());
    load();
    super.initState();
  }

  Future<List<VanBanDiGuiNhanItem>> lstthongtinguinhan;
  void load() {
    var dataquery = {"VanBanID": '' + widget.id.toString() + '', "lang": 'vi'};
    lstthongtinguinhan = objapi.getvanbandiguinhan(dataquery);
  }

  Widget contentbody() => Center(
          child: FutureBuilder(
        future: lstthongtinguinhan,
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
      body: BlocBuilder<BlocVanBanDiAction, ActionState>(
        buildWhen: (previousState, state) {
          if (state is ViewState) {
            load();
          }
          return;
        },
        builder: (context, state) {
          return contentbody();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SimpleRouter.forward(MyVanBanDiGuiNhanForm(id: widget.id));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
