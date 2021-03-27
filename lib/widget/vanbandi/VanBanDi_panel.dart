import 'package:flutter/material.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';
import 'package:app_eoffice/widget/Base_widget.dart';

import 'VanBanDiListItem.dart';

// ignore: must_be_immutable
class VanBanDiPanel extends StatefulWidget {
  VanBanDiBloc vanBanDiBloc;
  ScrollController scrollController_rq;
  VanBanDiPanel({this.vanBanDiBloc, this.scrollController_rq});
  _VanBanDiPanel createState() => _VanBanDiPanel();
}

class _VanBanDiPanel extends State<VanBanDiPanel>
    with SingleTickerProviderStateMixin {
  @override
  void dispose() {
    widget.vanBanDiBloc.dispose();
    widget.scrollController_rq.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.vanBanDiBloc.topStories,
      builder:
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<List<VanBanDiItem>> snapshot) {
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

  Widget _buildView({List<VanBanDiItem> topStories}) {
    return ListView.builder(
      controller: widget.scrollController_rq,
      itemCount: widget.vanBanDiBloc.hasMoreStories()
          ? topStories.length + 1
          : topStories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == topStories.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return VanBanDiListItem(
          obj: topStories[index],
        );
      },
    );
  }
}
