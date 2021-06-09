import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/notification_block.dart';
import 'package:app_eoffice/views/Notification/Notification_All.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_router/simple_router.dart';

int currentPage = 0;
int currentPageNow = 1;

// class Notificationpage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MyNotificationpage();
//   }
// }

String keyword = '';
int indexselect = 0;
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyNotificationpage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyNotificationpage({this.globalKey});
  @override
  _MyNotificationpage createState() => _MyNotificationpage();
}

class _MyNotificationpage extends State<MyNotificationpage>
    with SingleTickerProviderStateMixin {
  List<StatefulWidget> lsttabview = <StatefulWidget>[];
  @override
  void initState() {
    super.initState();
    keyword = '';
    if (nguoidungsession != null) {}
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Thông báo cá nhân',
      style: TextStyle(
        color: Colors.white,
      ));
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: colorbartop,
              leading: new IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    widget.globalKey.currentState.openDrawer();
                  }),
              actions: <Widget>[
                IconButton(
                  icon: cusIcon,
                  onPressed: () {
                    setState(() {
                      if (this.cusIcon.icon == Icons.search) {
                        this.cusIcon = Icon(Icons.cancel, color: Colors.white);
                        this.cusSearchBar = TextField(
                          decoration:
                              new InputDecoration(labelText: "Nhập từ khóa"),
                          textInputAction: TextInputAction.go,
                          onSubmitted: (String str) {
                            setState(() {
                              keyword = str;
                            });
                          },
                          autofocus: true,
                        );
                      } else {
                        keyword = '';
                        currentPage = 1;
                        cusIcon = Icon(Icons.search, color: Colors.white);
                        cusSearchBar = Text('Thông báo cá nhân',
                            style: TextStyle(
                              color: Colors.white,
                            ));
                      }
                    });
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.more_vert),
                //   onPressed: () {},
                //   color: Colors.white,
                // )
              ],
              title: cusSearchBar),
          preferredSize: Size.fromHeight(50),
        ),
        body: DefaultTabController(
            length: 3,
            child: new Scaffold(
              body: Center(
                child: Provider<NotificationBloc>(
                  child: MyNotificationAllpage(
                    requestkeyword: keyword,
                    requestblock: new NotificationBloc(keyword, 0),
                  ),
                  create: (context) => new NotificationBloc(keyword, 0),
                  dispose: (context, bloc) => bloc.dispose(),
                ),
              ),
            )));
  }
}
