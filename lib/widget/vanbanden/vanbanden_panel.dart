import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/widget/vanbanden/vanbanden_list_item.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VanBanDenPanel extends StatefulWidget {
  VanBanDenBloc vanBanDenBloc;
  ScrollController scrollController_rq;
  VanBanDenPanel({@required this.vanBanDenBloc, this.scrollController_rq});
  _VanBanDenPanel createState() => _VanBanDenPanel();
}

RefreshController _refreshController = RefreshController(initialRefresh: false);

class _VanBanDenPanel extends State<VanBanDenPanel>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    widget.vanBanDenBloc.dispose();
    widget.scrollController_rq.dispose();
    print('đóng văn bản đến');
    super.dispose();
  }

  GlobalKey<ScaffoldState> _scaffoldKeyrefeshVBDen = GlobalKey<ScaffoldState>();
  Widget _buildView({List<VanBanDenItem> topStories}) {
    return SmartRefresher(
        controller: _refreshController,
        key: _scaffoldKeyrefeshVBDen,
        header: ClassicHeader(
          idleText: 'Đang tải dữ liệu',
          completeText: 'Tải dữ liệu thành công',
          refreshingText: 'Đang tải',
          releaseText: 'Đang tải lại',
        ),
        child: ListView.builder(
          controller: widget.scrollController_rq,
          itemCount: widget.vanBanDenBloc.hasMoreStories()
              ? topStories.length + 1
              : topStories.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == topStories.length) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return VanBanDenListItem(
              obj: topStories[index],
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.vanBanDenBloc.topStories,
      builder:
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<List<VanBanDenItem>> snapshot) {
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
