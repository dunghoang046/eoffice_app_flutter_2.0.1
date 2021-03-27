import 'package:flutter/material.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanpanel.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/Base.dart';

class MyDuThaoVanBanAllpage extends StatefulWidget {
  final String requestkeyword;
  DuThaoVanBanblock requestblock;
  MyDuThaoVanBanAllpage({this.requestkeyword, this.requestblock});
  _MyDuThaoVanBanAllpage createState() => _MyDuThaoVanBanAllpage();
}

String keyword = '';

class _MyDuThaoVanBanAllpage extends State<MyDuThaoVanBanAllpage>
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
    // _scrollController.dispose();
    // widget.requestblock.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<DuThaoVanBanblock>(context);
  }

  @override
  Widget build(BuildContext context) {
    return DuThaoVanBanpanel(
      vanBanDiBloc: widget.requestblock,
      scrollController_rq: _scrollController,
    );
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
