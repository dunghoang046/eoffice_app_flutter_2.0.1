import 'package:app_eoffice/models/ThongTinDatXeItem.dart';
import 'package:app_eoffice/views/DatXe/DatXe_ChiTiet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';

import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:app_eoffice/widget/NoInternetConnection.dart';
import 'package:date_format/date_format.dart';

class DatXepanel extends StatefulWidget {
  DatXeblock objBloc;
  ScrollController scrollController_rq;
  DatXepanel({@required this.objBloc, this.scrollController_rq});

  _DatXepanel createState() => _DatXepanel();
}

bool inter = true;
bool check = true;
int totals = 0;

class _DatXepanel extends State<DatXepanel> {
  @override
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    print('đóng ds cv panl');
    widget.objBloc.dispose();
    widget.scrollController_rq.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.objBloc.topStories,
      builder:
          // ignore: missing_return
          (BuildContext context,
              AsyncSnapshot<List<ThongTinDatXeItem>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()));
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && widget.objBloc.inter == true) {
              if (snapshot.data.length != null && snapshot.data.length > 0) {
                return _buildView(topStories: snapshot.data);
              } else {
                return notrecord();
              }
            } else if (widget.objBloc.inter != true) {
              return NoInternetConnection();
            }
            break;
        }
      },
    );
  }

  Widget _buildView({List<ThongTinDatXeItem> topStories}) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: widget.scrollController_rq,
      itemCount: widget.objBloc.hasMoreStories()
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
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: topStories[index].trangthaiid == 3
                        ? Colors.green
                        : (topStories[index].trangthaiid == 2
                            ? Colors.red
                            : Colors.black54),
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyDatXeChiTiet(
                                id: topStories[index].id,
                              )));
                },
                title: Text(
                    topStories[index].mota != null
                        ? topStories[index].mota
                        : '',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold)),
                subtitle: Column(
                  children: <Widget>[
                    if (topStories[index].tennguoitao.length > 0)
                      containerRow(
                        'Người tạo: ',
                        topStories[index].tennguoitao,
                      ),
                    if (topStories[index].tenphongban.length > 0)
                      containerRow(
                          'Phòng ban: ', topStories[index].tenphongban),
                    containerRow(
                        '',
                        (topStories[index].thoigianbatdau != null
                                ? formatDate(
                                    DateTime.parse(
                                        topStories[index].thoigianbatdau),
                                    [dd, '/', mm, '/', yyyy])
                                : '') +
                            (topStories[index].thoigianketthuc != null
                                ? ' - ' +
                                    formatDate(
                                        DateTime.parse(
                                            topStories[index].thoigianketthuc),
                                        [dd, '/', mm, '/', yyyy])
                                : ''))
                  ],
                )),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Sửa',
              color: Colors.black45,
              icon: Icons.more_horiz,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyThemMoiCongViec(
                              id: topStories[index].id,
                            )));
              },
            ),
            IconSlideAction(
              caption: 'Xóa',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                setState(() {
                  topStories.removeAt(index);
                  setState(() {
                    widget.objBloc.totaldelete = widget.objBloc.totaldelete + 1;
                    if (widget.objBloc.total >
                            (topStories.length + widget.objBloc.totaldelete) &&
                        widget.objBloc.isloadingdelete) {
                      widget.objBloc.loadMore('', 0);
                    } else
                      widget.objBloc.isloadingdelete = false;
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
