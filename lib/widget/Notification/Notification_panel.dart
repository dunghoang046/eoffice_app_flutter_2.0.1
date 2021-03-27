import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/block/notification_block.dart';
import 'package:app_eoffice/widget/Notification/NotificationListItem.dart';
// import 'package:app_eoffice/widget/Base_widget.dart';

import 'package:app_eoffice/models/NotificationItem.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class NotificationPanel extends StatefulWidget {
  NotificationBloc notificationBloc;
  ScrollController scrollController_rq;
  NotificationPanel({this.notificationBloc, this.scrollController_rq});
  _NotificationPanel createState() => _NotificationPanel();
}

class _NotificationPanel extends State<NotificationPanel>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    widget.notificationBloc.dispose();
    widget.scrollController_rq.dispose();
    print('Đóng notification');
    super.dispose();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  Widget _buildView({List<NotificationItem> topStories}) {
    return SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        enablePullDown: true,
        enablePullUp: false,
        header: ClassicHeader(
          idleText: 'Đang tải dữ liệu',
          completeText: 'Tải dữ liệu thành công',
          refreshingText: 'Đang tải',
          releaseText: 'Đang tải lại',
        ),
        child: ListView.builder(
          controller: widget.scrollController_rq,
          itemCount: widget.notificationBloc.hasMoreStories()
              ? topStories.length + 1
              : topStories.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == topStories.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return NotificationListItem(
              obj: topStories[index],
            );
            // return Center(child: Text(''));
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.notificationBloc.topStories,
      builder:
          // ignore: missing_return
          (BuildContext context,
              AsyncSnapshot<List<NotificationItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()));
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.data.length > 0) {
              return _buildView(topStories: snapshot.data);
            } else {
              return notrecord();
            }
            break;
        }
      },
    );
  }
}
