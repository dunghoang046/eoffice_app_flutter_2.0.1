import 'package:app_eoffice/block/Thongbaobloc.dart';
import 'package:app_eoffice/widget/ThongBao/ThongBao_panel.dart';
import 'package:flutter/material.dart';
// import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:provider/provider.dart';

Vanbanden_api vbdenapi;

class MyThongBaoAllpage extends StatefulWidget {
  final String requestkeyword;
  ThongBaoBloc requestblock;

  MyThongBaoAllpage({
    this.requestkeyword,
    this.requestblock,
  });
  _MyThongBaoAllpage createState() => _MyThongBaoAllpage();
}

String keyword = '';

class _MyThongBaoAllpage extends State<MyThongBaoAllpage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreTopStoriesIfNeed);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<ThongBaoBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ThongBaoPanel(
      notificationBloc: widget.requestblock,
      scrollController_rq: _scrollController,
    );
    // return Center(child: Text(''));
  }

  void _loadMoreTopStoriesIfNeed() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.requestblock.loadMore(
          widget.requestkeyword != null ? widget.requestkeyword : '', 0);
    }
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        setState(() {
          widget.requestblock.loadtop(
              widget.requestkeyword != null ? widget.requestkeyword : '', 0);
        });
      }
    }
  }
}
