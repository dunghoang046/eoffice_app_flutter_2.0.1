import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/widget/vanbanden/vanbanden_panel.dart';
import 'package:provider/provider.dart';

Vanbanden_api vbdenapi;

class MyVanBanDenAllpage extends StatefulWidget {
  final String requestkeyword;
  VanBanDenBloc requestblock;
  final int loai;
  final int loaiListID;
  final int checkvt;
  MyVanBanDenAllpage(
      {this.requestkeyword,
      this.requestblock,
      this.loai,
      this.loaiListID,
      this.checkvt});
  _MyVanBanDenAllpage createState() => _MyVanBanDenAllpage();
}

String keyword = '';

class _MyVanBanDenAllpage extends State<MyVanBanDenAllpage>
    with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController(
    // initialScrollOffset: 10,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreTopStoriesIfNeed);
  }

  @override
  void dispose() {
    widget.requestblock.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<VanBanDenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return VanBanDenPanel(
      vanBanDenBloc: widget.requestblock,
      scrollController_rq: _scrollController,
    );
  }

  void _loadMoreTopStoriesIfNeed() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      widget.requestblock.loadMore(
          widget.requestkeyword != null ? widget.requestkeyword : '',
          widget.loai,
          widget.loaiListID,
          widget.checkvt);
    }
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        setState(() {
          widget.requestblock.loadtop(
              widget.requestkeyword != null ? widget.requestkeyword : '',
              widget.loai,
              widget.loaiListID,
              widget.checkvt);
        });
      }
    }
  }
}
