import 'package:flutter/material.dart';
// import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:provider/provider.dart';

import 'package:app_eoffice/widget/Notification/Notification_panel.dart';

import 'package:app_eoffice/block/notification_block.dart';
import 'package:simple_router/simple_router.dart';

Vanbanden_api vbdenapi;

class MyNotificationAllpage extends StatefulWidget {
  final String requestkeyword;
  NotificationBloc requestblock;

  MyNotificationAllpage({
    this.requestkeyword,
    this.requestblock,
  });
  _MyNotificationAllpage createState() => _MyNotificationAllpage();
}

String keyword = '';

class _MyNotificationAllpage extends State<MyNotificationAllpage>
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
    widget.requestblock = Provider.of<NotificationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationPanel(
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
