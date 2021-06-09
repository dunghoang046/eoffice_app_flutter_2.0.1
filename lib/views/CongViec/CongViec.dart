import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/CongViec/CongViec_All.dart';
import 'package:app_eoffice/views/CongViec/CongViec_ThemMoi.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:simple_router/simple_router.dart';

int currentPage = 0;
int currentPageNow = 1;

class CongViecpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyCongViecpage();
  }
}

TabController _tabController;
String keyword = '';
int indexselect = 0;
bool inter = true;

class MyCongViecpage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyCongViecpage({this.globalKey});
  @override
  _MyCongViecpage createState() => _MyCongViecpage();
}

class _MyCongViecpage extends State<MyCongViecpage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = <Tab>[];
  List<StatefulWidget> lsttabview = <StatefulWidget>[];
  @override
  void initState() {
    super.initState();
    keyword = '';
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Công việc',
      style: TextStyle(
        color: Colors.white,
      ));
  @override
  void dispose() {
    super.dispose();
  }

  checkinter() async {
    inter = await checkinternet();
    if (!inter) {
      on_alter(context, 'Vui lòng check lại internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: lstmenu(context),
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
                      cusSearchBar = Text('Công việc',
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
      body: Center(
        child: Provider<CongViecblock>(
          child: MyCongViecAllpage(
            requestkeyword: keyword,
            requestblock: new CongViecblock(keyword, 0),
          ),
          create: (context) => new CongViecblock(keyword, 0),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          SimpleRouter.forward(MyThemMoiCongViec(
            id: 0,
            parentID: 0,
          ));
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
