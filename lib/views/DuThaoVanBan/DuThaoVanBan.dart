import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/utils/menu.dart';
import 'package:app_eoffice/views/DuThaoVanBan/DuThaoVanBan_all.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';

int currentPage = 0;
int currentPageNow = 1;

class DuThaoVanBanpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyDuThaoVanBanpage();
  }
}

TabController _tabController;
String keyword = '';
int indexselect = 0;

class MyDuThaoVanBanpage extends StatefulWidget {
  @override
  _MyDuThaoVanBanpage createState() => _MyDuThaoVanBanpage();
}

class _MyDuThaoVanBanpage extends State<MyDuThaoVanBanpage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = new List<Tab>();
  List<StatefulWidget> lsttabview = new List<StatefulWidget>();
  @override
  void initState() {
    super.initState();

    keyword = '';
    if (nguoidungsession != null)
      _tabController = TabController(vsync: this, length: 5);
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Dự thảo văn bản',
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
        drawer: lstmenu(context),
        appBar: PreferredSize(
          child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: colorbar,
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
                        cusSearchBar = Text('Dự thảo văn bản',
                            style: TextStyle(
                              color: Colors.white,
                            ));
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                  color: Colors.white,
                )
              ],
              title: cusSearchBar),
          preferredSize: Size.fromHeight(50),
        ),
        body: DefaultTabController(
            length: 5,
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
                      new Tab(text: 'Chưa XL'),
                      new Tab(text: 'Đang XL'),
                      new Tab(text: 'Đã XL'),
                      new Tab(text: 'Chờ phát hành'),
                    ],
                    labelColor: Colors.blue,
                  ),
                ),
              ),
              body: Center(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Provider<DuThaoVanBanblock>(
                      child: MyDuThaoVanBanAllpage(
                        requestkeyword: keyword,
                        requestblock: new DuThaoVanBanblock(keyword, 0),
                      ),
                      create: (context) => new DuThaoVanBanblock(keyword, 0),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<DuThaoVanBanblock>(
                      child: MyDuThaoVanBanAllpage(
                        requestkeyword: keyword,
                        requestblock: new DuThaoVanBanblock(keyword, 1),
                      ),
                      create: (context) => new DuThaoVanBanblock(keyword, 1),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<DuThaoVanBanblock>(
                      child: MyDuThaoVanBanAllpage(
                        requestkeyword: keyword,
                        requestblock: new DuThaoVanBanblock(keyword, 2),
                      ),
                      create: (context) => new DuThaoVanBanblock(keyword, 2),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<DuThaoVanBanblock>(
                      child: MyDuThaoVanBanAllpage(
                        requestkeyword: keyword,
                        requestblock: new DuThaoVanBanblock(keyword, 3),
                      ),
                      create: (context) => new DuThaoVanBanblock(keyword, 3),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<DuThaoVanBanblock>(
                      child: MyDuThaoVanBanAllpage(
                        requestkeyword: keyword,
                        requestblock: new DuThaoVanBanblock(keyword, 4),
                      ),
                      create: (context) => new DuThaoVanBanblock(keyword, 4),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                  ],
                ),
              ),
            )));
  }
}
