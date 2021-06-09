import 'package:app_eoffice/views/CongViec/CongViec_ChiTiet.dart';
import 'package:app_eoffice/views/DatXe/DatXe.dart';
import 'package:app_eoffice/views/DatXe/DatXe_ChiTiet.dart';
import 'package:app_eoffice/views/DuThaoVanBan/VanBanDuThao_ChiTiet.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_chitiet.dart';
import 'package:app_eoffice/views/VanBanDi/VanBandi_Chtiet.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/block/notification_block.dart';
import 'package:app_eoffice/widget/Notification/NotificationListItem.dart';
// import 'package:app_eoffice/widget/Base_widget.dart';

import 'package:app_eoffice/models/NotificationItem.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_router/simple_router.dart';
import 'package:date_format/date_format.dart';

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

  GlobalKey<ScaffoldState> _scaffoldKeyrefeshNoti = GlobalKey<ScaffoldState>();
  void _ontap(NotificationItem notificationitem) {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => MyNotitest()));

    if (notificationitem.kieuid == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyVanVanDiChiTiet(
                    id: notificationitem.itemid,
                  )));
    }
    if (notificationitem.kieuid == 1 || notificationitem.kieuid == 14) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => VanBanDenChiTiet(
      //               id: notificationitem.itemid,
      //             )));
      SimpleRouter.forward(VanBanDenChiTiet(id: notificationitem.itemid));
    }
    if (notificationitem.kieuid == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyDuThaoVanBanChiTiet(id: notificationitem.itemid)));
    }
    if (notificationitem.kieuid == 8) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyCongViecChiTiet(
                    id: notificationitem.itemid,
                  )));
    }
    if (notificationitem.kieuid == 17) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyDatXeChiTiet(
                    id: notificationitem.itemid,
                  )));
    }
  }

  Widget _buildView({List<NotificationItem> topStories}) {
    return SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        key: _scaffoldKeyrefeshNoti,
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
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 7), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(3, 3, 0, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ListTile(
                    onTap: () {
                      setState(() {
                        topStories.removeAt(index);
                        widget.notificationBloc.loadMore('', 0);
                        _ontap(topStories[index]);
                      });
                    },
                    title: Text(
                        topStories[index].noidung != null
                            ? topStories[index].noidung
                            : '',
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                    subtitle: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                child: Icon(
                                  Icons.alarm,
                                  size: 13,
                                )),
                            Expanded(
                              // margin: const EdgeInsets.only(left: 4.0),
                              child: Text(
                                topStories[index].tennguoigui +
                                    ' gửi lúc: ' +
                                    (topStories[index].ngaytao != null
                                        ? formatDate(
                                            DateTime.parse(
                                                topStories[index].ngaytao),
                                            [dd, '/', mm, '/', yyyy])
                                        : ''),
                                style: TextStyle(fontSize: 13),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
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
