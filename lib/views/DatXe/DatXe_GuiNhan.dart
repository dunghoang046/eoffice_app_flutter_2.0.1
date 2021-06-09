import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/ThongTinDatXeGuiNhanItem.dart';
import 'package:app_eoffice/services/DatXe_Api.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/DatXe/DatXeGuiNhanPanel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_router/simple_router.dart';

class MyDatXeGuiNhan extends StatefulWidget {
  final int id;
  MyDatXeGuiNhan({this.id});
  _MyDatXeGuiNhan createState() => _MyDatXeGuiNhan();
}

Future<List<ThongTinDatXeGuiNhanItem>> lstobj;
DatXe_Api objapi = new DatXe_Api();
List<int> lstid = <int>[];

class _MyDatXeGuiNhan extends State<MyDatXeGuiNhan> {
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
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      lstobj = objapi.getdatxeguinhan(dataquery);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Thông tin đặt xe gửi nhận',
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
            List<ThongTinDatXeGuiNhanItem> list = snapshot.data;
            if (list.length > 0)
              return DatXeGuiNhanpanel(lstobjguinhan: list);
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
