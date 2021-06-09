import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/vanbandi_block.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/services/Base_service.dart';

import 'vanbandi_all.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';

int currentPage = 0;
int currentPageNow = 1;

class VanBanDipage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyVanBanDipage();
  }
}

TabController _tabController;
String keyword = '';
int indexselect = 0;

class MyVanBanDipage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyVanBanDipage({this.globalKey});
  @override
  _MyVanBanDipage createState() => _MyVanBanDipage();
}

class _MyVanBanDipage extends State<MyVanBanDipage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = <Tab>[];
  List<StatefulWidget> lsttabview = <StatefulWidget>[];
  @override
  void initState() {
    super.initState();

    keyword = '';
    if (nguoidungsession != null)
      _tabController = TabController(vsync: this, length: 2);
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Văn bản đi',
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
                    if (widget.globalKey.currentState.isDrawerOpen) {
                      widget.globalKey.currentState.openEndDrawer();
                    } else {
                      widget.globalKey.currentState.openDrawer();
                    }
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
                        cusSearchBar = Text('Văn bản đi',
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
            length: 2,
            child: new Scaffold(
              appBar: new PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: new Container(
                  height: 50.0,
                  child: new TabBar(
                    onTap: (index) {
                      setState(() {
                        indexselect = index;
                      });
                    },
                    controller: _tabController,
                    tabs: [
                      new Tab(text: 'Tất cả'),
                      new Tab(text: 'Thu hồi'),
                    ],
                    labelColor: Colors.blue,
                  ),
                ),
              ),
              body: Center(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Provider<VanBanDiBloc>(
                      child: MyVanBanDiAllpage(
                        requestkeyword: keyword,
                        requestblock: new VanBanDiBloc(keyword, 0),
                      ),
                      create: (context) => new VanBanDiBloc(keyword, 0),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<VanBanDiBloc>(
                      child: MyVanBanDiAllpage(
                        requestkeyword: keyword,
                        requestblock: new VanBanDiBloc(keyword, 1),
                      ),
                      create: (context) => new VanBanDiBloc(keyword, 1),
                      dispose: (context, bloc) => bloc.dispose(),
                    )
                  ],
                ),
              ),
            )));
  }
}
