import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/ThongTinDatXeGuiNhanItem.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanGuiNhanpanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_router/simple_router.dart';

class MyDuThaoVanBanGuiNhan extends StatefulWidget {
  final int id;
  MyDuThaoVanBanGuiNhan({this.id});
  _MyDuThaoVanBanGuiNhan createState() => _MyDuThaoVanBanGuiNhan();
}

Future<List<VanBanDiGuiNhanItem>> lstobj;
DuThaoVanBan_api objapi = new DuThaoVanBan_api();
List<int> lstid = <int>[];

class _MyDuThaoVanBanGuiNhan extends State<MyDuThaoVanBanGuiNhan> {
  // ignore: must_call_super
  @override
  void initState() {
    loaddata();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loaddata() async {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"VanBanID": '' + widget.id.toString() + ''};
      lstobj = objapi.getduthaovanbanguinhan(dataquery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
      body: BlocBuilder<BlocDatXeAction, ActionState>(
          buildWhen: (previousState, state) {
        if (state is ViewState) {
          loaddata();
        }
        return;
      }, builder: (context, state) {
        return contentbody();
      }),
    ));
  }

  Widget contentbody() => Center(
          child: FutureBuilder(
        future: lstobj,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.hasData) {
            List<VanBanDiGuiNhanItem> list = snapshot.data;
            if (list.length > 0)
              return DuThaoVanBanGuiNhanpanel(lstobjguinhan: list);
            else
              return notrecord();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
}
