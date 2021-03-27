import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbanden_ChuaChuyenbloc.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_all.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_chuaxuly.dart';
import 'package:provider/provider.dart';

class MyVanBanDenTabView extends StatefulWidget {
  final indexselect;
  final String keyword;
  MyVanBanDenTabView({this.indexselect, this.keyword});
  _MyVanBanDenTabView createState() => _MyVanBanDenTabView();
}

class _MyVanBanDenTabView extends State<MyVanBanDenTabView> {
  List<Widget> lstw = new List<Widget>();
  List<Widget> lstww = new List<Widget>();
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TabBarView(
        children:
            // widget.indexselect == 0 ? lstw : lstww
            [
          new Provider<VanBanDenBloc>(
            child: MyVanBanDenAllpage(
              requestkeyword: widget.keyword,
              requestblock: new VanBanDenBloc(widget.keyword, 3, 0, 1),
              loai: 3,
              loaiListID: 0,
              checkvt: 1,
            ),
            create: (context) => new VanBanDenBloc(widget.keyword, 3, 0, 1),
            dispose: (context, bloc) => bloc.dispose(),
          ),
          new Provider<VanBanDenChuaChuyenBloc>(
            child: MyVanBanDenChuaXuLypage(
                requestkeyword: widget.keyword,
                requestblock:
                    new VanBanDenChuaChuyenBloc(widget.keyword, 0, 0, 1),
                loai: 0,
                loaiListID: 0,
                checkvt: 1),
            create: (context) =>
                new VanBanDenChuaChuyenBloc(widget.keyword, 0, 0, 1),
            dispose: (context, bloc) => bloc.dispose(),
          ),
          new Provider<VanBanDenBloc>(
            child: MyVanBanDenAllpage(
              requestkeyword: widget.keyword,
              requestblock: new VanBanDenBloc(widget.keyword, 5, 0, 1),
              loai: 5,
              loaiListID: 0,
              checkvt: 1,
            ),
            create: (context) => new VanBanDenBloc(widget.keyword, 5, 0, 1),
            dispose: (context, bloc) => bloc.dispose(),
          ),
        ],
      ),
    );
  }
}
