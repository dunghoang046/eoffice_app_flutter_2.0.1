import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/vanbanden_ChuaChuyenbloc.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/views/VanBanDen/vanbanden_all.dart';

import 'package:app_eoffice/views/VanBanDen/vanbanden_chuaxuly.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';

int currentPage = 0;
int currentPageNow = 1;
bool isLoading = false;
int indexselecttab = 0;

// class VanBanDenVanThupage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MyVanBanDenVanThupage();
//   }
// }

String keyword = '';

class MyVanBanDenVanThupage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyVanBanDenVanThupage({this.globalKey});
  @override
  _MyVanBanDenVanThupage createState() => _MyVanBanDenVanThupage();
}

TabController _tabController;

class _MyVanBanDenVanThupage extends State<MyVanBanDenVanThupage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = <Tab>[];
  List<Widget> lstw = <Widget>[];
  List<StatefulWidget> lsttabview = <StatefulWidget>[];
  @override
  void initState() {
    indexselecttab = 0;
    keyword = '';
    super.initState();
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Văn bản đến',
      style: TextStyle(
        color: Colors.white,
      ));
  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // drawer: lstmenu(context),
        appBar: PreferredSize(
          child: AppBar(
              backgroundColor: colorbar,
              iconTheme: IconThemeData(color: Colors.white),
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
                          decoration: new InputDecoration(
                              labelText: "Nhập từ khóa",
                              labelStyle: TextStyle(color: Colors.white)),
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
                    indicatorColor: Colors.blue,
                    controller: _tabController,
                    onTap: (index) {
                      setState(() {
                        indexselecttab = index;
                      });
                    },
                    tabs: [
                      new Tab(text: 'Tất cả'),
                      new Tab(text: 'Chưa chuyển'),
                      new Tab(text: 'Đã chuyển')
                    ],
                    labelColor: Colors.blue,
                  ),
                ),
              ),
              // body: MyVanBanDenTabView(
              //   indexselect: indexselecttab,
              //   keyword: keyword,
              // )
              body: Center(
                child: TabBarView(
                  children:
                      // widget.indexselect == 0 ? lstw : lstww
                      [
                    new Provider<VanBanDenBloc>(
                      child: MyVanBanDenAllpage(
                        requestkeyword: keyword,
                        requestblock: new VanBanDenBloc(keyword, 3, 0, 1),
                        loai: 3,
                        loaiListID: 0,
                        checkvt: 1,
                      ),
                      create: (context) => new VanBanDenBloc(keyword, 3, 0, 1),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    new Provider<VanBanDenChuaChuyenBloc>(
                      child: MyVanBanDenChuaXuLypage(
                          requestkeyword: keyword,
                          requestblock:
                              new VanBanDenChuaChuyenBloc(keyword, 0, 0, 1),
                          loai: 0,
                          loaiListID: 0,
                          checkvt: 1),
                      create: (context) =>
                          new VanBanDenChuaChuyenBloc(keyword, 0, 0, 1),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                    new Provider<VanBanDenBloc>(
                      child: MyVanBanDenAllpage(
                        requestkeyword: keyword,
                        requestblock: new VanBanDenBloc(keyword, 5, 0, 1),
                        loai: 5,
                        loaiListID: 0,
                        checkvt: 1,
                      ),
                      create: (context) => new VanBanDenBloc(keyword, 5, 0, 1),
                      dispose: (context, bloc) => bloc.dispose(),
                    ),
                  ],
                ),
              ),
            )));
  }
}
