import 'package:app_eoffice/block/LichlamViecbloc.dart';
import 'package:app_eoffice/models/YearWeekItem.dart';
import 'package:app_eoffice/views/LichlamViec/LichlamViec.dart';
import 'package:app_eoffice/widget/LichlamViec/LichLamViec_panel.dart';
import 'package:flutter/material.dart';
// import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:provider/provider.dart';

import 'package:app_eoffice/widget/Notification/Notification_panel.dart';

Vanbanden_api vbdenapi;

class MyLichlamViecAllpage extends StatefulWidget {
  final String requestweek;
  final String requesyear;
  final String requesloai;
  LichlamViecBloc requestblock;

  MyLichlamViecAllpage({
    this.requestweek,
    this.requesyear,
    this.requestblock,
    this.requesloai,
  });
  _MyLichlamViecAllpage createState() => _MyLichlamViecAllpage();
}

int selectedValue = 0;
String keyword = '';

class _MyLichlamViecAllpage extends State<MyLichlamViecAllpage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    // _scrollController.addListener(_loadMoreTopStoriesIfNeed);
    // var requestdata = {'week': widget.requestweek, 'year': widget.requesyear};
    widget.requestblock.loadMore(widget.requesyear, widget.requestweek,widget.requesloai);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<LichlamViecBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return LichlamViecPanel(
      lichlamviecBloc: widget.requestblock,
      scrollController_rq: _scrollController,
    );
    // return Center(child: Text(''));
  }

  void _loadMoreTopStoriesIfNeed() async {
    var requestdata = {'week': widget.requestweek, 'year': widget.requesyear};
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.requestblock.loadMore(widget.requestweek, widget.requesyear,widget.requesloai);
    }
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        setState(() {
          widget.requestblock.loadtop(widget.requestweek, widget.requesyear,widget.requesloai);
        });
      }
    }
  }
}
