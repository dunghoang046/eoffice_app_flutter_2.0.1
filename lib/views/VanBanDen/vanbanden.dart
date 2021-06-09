import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_all.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/services/Base_service.dart';

int currentPage = 0;
int currentPageNow = 1;

// class VanBanDenpage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MyVanBanDenpage();
//   }
// }

String keyword = '';
int indexselect = 0;

class MyVanBanDenpage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyVanBanDenpage({this.globalKey});
  @override
  _MyVanBanDenpage createState() => _MyVanBanDenpage();
}

TabController _tabController;

class _MyVanBanDenpage extends State<MyVanBanDenpage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = new List<Tab>();
  List<StatefulWidget> lsttabview = new List<StatefulWidget>();
  @override
  void initState() {
    super.initState();

    keyword = '';
    if (nguoidungsession != null) {
      _tabController = TabController(vsync: this, length: 3);
    }
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Văn bản đến',
      style: TextStyle(
        color: Colors.white,
      ));
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: lstmenu(context),
        appBar: PreferredSize(
          child: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: colorbar,
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
                        cusSearchBar = Text('Văn bản đến',
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
                      new Tab(text: 'Chưa xử lý'),
                      new Tab(text: 'Đã xử lý'),
                    ],
                    labelColor: Colors.blue,
                  ),
                ),
              ),
              body: Center(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Provider<VanBanDenBloc>(
                      child: MyVanBanDenAllpage(
                          requestkeyword: keyword,
                          requestblock: new VanBanDenBloc(keyword, 3, 0, 0),
                          loai: 3,
                          loaiListID: 0,
                          checkvt: 0),
                      create: (context) => new VanBanDenBloc(keyword, 3, 0, 0),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<VanBanDenBloc>(
                      child: MyVanBanDenAllpage(
                          requestkeyword: keyword,
                          requestblock: new VanBanDenBloc(keyword, 0, 0, 0),
                          loai: 0,
                          loaiListID: 0,
                          checkvt: 0),
                      create: (context) => new VanBanDenBloc(keyword, 0, 0, 0),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    Provider<VanBanDenBloc>(
                      child: MyVanBanDenAllpage(
                        requestkeyword: keyword,
                        requestblock: new VanBanDenBloc(keyword, 2, 2, 0),
                        loai: 2,
                        loaiListID: 2,
                        checkvt: 0,
                      ),
                      create: (context) => new VanBanDenBloc(keyword, 2, 2, 0),
                      dispose: (context, bloc) => bloc.dispose(),
                    )
                  ],
                ),
              ),
            )));
  }
}
