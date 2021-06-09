import 'package:app_eoffice/services/Base_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ChiTiet.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';

import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/NoInternetConnection.dart';
import 'package:date_format/date_format.dart';
import 'package:simple_router/simple_router.dart';

class CongViecpanel extends StatefulWidget {
  CongViecblock congviecBloc;
  ScrollController scrollController_rq;
  CongViecpanel({@required this.congviecBloc, this.scrollController_rq});

  _CongViecpanel createState() => _CongViecpanel();
}

bool inter = true;
bool check = true;
int totals = 0;

class _CongViecpanel extends State<CongViecpanel> {
  @override
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    print('đóng ds cv panl');
    widget.congviecBloc.dispose();
    widget.scrollController_rq.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.congviecBloc.topStories,
      builder:
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<List<WorkTaskItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()));
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && widget.congviecBloc.inter == true) {
              if (snapshot.data.length > 0) {
                return _buildView(topStories: snapshot.data);
              } else {
                return notrecord();
              }
            } else if (widget.congviecBloc.inter != true) {
              return NoInternetConnection();
            }
            break;
        }
      },
    );
  }

  Widget _buildView({List<WorkTaskItem> topStories}) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: widget.scrollController_rq,
      itemCount: widget.congviecBloc.hasMoreStories()
          ? topStories.length + 1
          : topStories.length,
      itemBuilder: (BuildContext context, int index) {
        if (index == topStories.length) {
          // if (index >= 10)
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        // return CongViecListItem(
        //   obj: topStories[index],
        // );
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: topStories[index].status == 3
                        ? Colors.green
                        : (topStories[index].status == 4
                            ? Colors.red
                            : Colors.amber),
                    width: 13),
              ),
              // borderRadius: BorderRadius.circular(10),
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
            margin: EdgeInsets.fromLTRB(15, 8, 10, 0),
            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: ListTile(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MyCongViecChiTiet(
                  //               id: topStories[index].id,
                  //             )));
                  SimpleRouter.forward(
                      MyCongViecChiTiet(id: topStories[index].id));
                },
                title: Text(
                    topStories[index].title != null
                        ? topStories[index].title
                        : '',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: <Widget>[
                    if (topStories[index].ltsUserPerform.length > 0)
                      containerRow(
                          'Thực hiện: ',
                          topStories[index]
                              .ltsUserPerform
                              .map((value) => value.fullName)
                              .join(', ')),
                    if (topStories[index].ltsGroupPerform.length > 0)
                      containerRow(
                          'Đơn vị xử lý: ',
                          topStories[index]
                              .ltsGroupPerform
                              .map((value) => value.fullName)
                              .join(', ')),
                    if (topStories[index].ltsUserGroupPerform.length > 0)
                      containerRow(
                          'Nhóm thực hiện: ',
                          topStories[index]
                              .ltsUserGroupPerform
                              .map((value) => value.fullName)
                              .join(', ')),
                    containerRow(
                        '',
                        (topStories[index].startDate != null
                                ? formatDate(
                                    DateTime.parse(topStories[index].startDate),
                                    [dd, '/', mm, '/', yyyy])
                                : '') +
                            (topStories[index].endDate != null
                                ? ' - ' +
                                    formatDate(
                                        DateTime.parse(
                                            topStories[index].endDate),
                                        [dd, '/', mm, '/', yyyy])
                                : ''))
                  ],
                )),
          ),
          secondaryActions: <Widget>[
            if (topStories[index].createdUserID == nguoidungsession.id)
              IconSlideAction(
                caption: 'Sửa',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MyThemMoiCongViec(
                  //               id: topStories[index].id,
                  //             )));
                  SimpleRouter.forward(
                      MyThemMoiCongViec(id: topStories[index].id));
                },
              ),
            if (topStories[index].createdUserID == nguoidungsession.id)
              IconSlideAction(
                caption: 'Xóa',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    topStories.removeAt(index);
                    setState(() {
                      widget.congviecBloc.totaldelete =
                          widget.congviecBloc.totaldelete + 1;
                      if (widget.congviecBloc.total >
                              (topStories.length +
                                  widget.congviecBloc.totaldelete) &&
                          widget.congviecBloc.isloadingdelete) {
                        widget.congviecBloc.loadMore('', 0);
                      } else
                        widget.congviecBloc.isloadingdelete = false;
                      // }
                    });
                  });
                },
              ),
          ],
        );
      },
    );
  }

  Widget containerRow(String label, String value) => Container(
        padding: EdgeInsets.fromLTRB(0, 2, 10, 2),
        child: Row(
          children: <Widget>[
            Expanded(
                child: RichText(
                    softWrap: true,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: label + '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: value, style: TextStyle(color: Colors.black))
                    ])))
          ],
        ),
      );
}
