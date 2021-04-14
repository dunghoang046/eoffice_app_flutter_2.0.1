import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDi_panel.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/Base.dart';

Vanbanden_api vbdenapi;

class MyVanBanDiAllpage extends StatefulWidget {
  final String requestkeyword;
  VanBanDiBloc requestblock;
  MyVanBanDiAllpage({this.requestkeyword, this.requestblock});
  _MyVanBanDiAllpage createState() => _MyVanBanDiAllpage();
}

String keyword = '';

class _MyVanBanDiAllpage extends State<MyVanBanDiAllpage>
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<VanBanDiBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: loadtop,
        child: VanBanDiPanel(
          vanBanDiBloc: widget.requestblock,
          scrollController_rq: _scrollController,
        ));
  }

  Future<Null> loadtop() async {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        setState(() {
          widget.requestblock.loadtop(
              widget.requestkeyword != null ? widget.requestkeyword : '', 0);
        });
      }
    }
    return null;
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
          Future.delayed(const Duration(milliseconds: 5000), () {
            loaddataerror();
          });
          widget.requestblock.loadtop(
              widget.requestkeyword != null ? widget.requestkeyword : '', 0);
        });
      }
    }
  }
}
