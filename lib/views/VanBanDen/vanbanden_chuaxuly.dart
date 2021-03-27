import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbanden_ChuaChuyenbloc.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/VanBanDenChuaChuyenPanel.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/Base.dart';

Vanbanden_api vbdenapi;

class MyVanBanDenChuaXuLypage extends StatefulWidget {
  final String requestkeyword;
  VanBanDenChuaChuyenBloc requestblock;
  final int loai;
  final int loaiListID;
  final int checkvt;
  MyVanBanDenChuaXuLypage(
      {this.requestkeyword,
      this.requestblock,
      this.loai,
      this.loaiListID,
      this.checkvt});
  _MyVanBanDenChuaXuLypage createState() => _MyVanBanDenChuaXuLypage();
}

String keyword = '';

class _MyVanBanDenChuaXuLypage extends State<MyVanBanDenChuaXuLypage>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreTopStoriesIfNeed);
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.requestblock.dispose();
  //   _scrollController.removeListener(_loadMoreTopStoriesIfNeed);
  //   super.dispose();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.requestblock = Provider.of<VanBanDenChuaChuyenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return VanBanDenChuaChuyenPanel(
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
          Future.delayed(const Duration(milliseconds: 5000), () {
            loaddataerror();
          });
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
