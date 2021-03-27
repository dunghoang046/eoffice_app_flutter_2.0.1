import 'package:flutter/material.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/DuThaoVanBanListItem.dart';

class DuThaoVanBanpanel extends StatelessWidget {
  DuThaoVanBanblock vanBanDiBloc;
  ScrollController scrollController_rq;
  DuThaoVanBanpanel({@required this.vanBanDiBloc, this.scrollController_rq});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: vanBanDiBloc.topStories,
      builder: (BuildContext context,
          AsyncSnapshot<List<DuThaoVanBanItem>> snapshot) {
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
            // TODO: Handle this case.
            break;
        }
      },
    );
  }

  Widget _buildView({List<DuThaoVanBanItem> topStories}) {
    return ListView.builder(
      controller: scrollController_rq,
      itemCount: vanBanDiBloc.hasMoreStories()
          ? topStories.length + 1
          : topStories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == topStories.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return DuThaoVanBanListItem(
          obj: topStories[index],
        );
      },
    );
  }
}
