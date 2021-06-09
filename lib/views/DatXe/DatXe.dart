import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/views/DatXe/DatXe_All.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/views/CongViec/CongViec_All.dart';
import 'package:provider/provider.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:simple_router/simple_router.dart';

int currentPage = 0;
int currentPageNow = 1;

class DatXepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyDatXepage();
  }
}

TabController _tabController;
String keyword = '';
int indexselect = 0;
bool inter = true;

class MyDatXepage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyDatXepage({this.globalKey});
  @override
  _MyDatXepage createState() => _MyDatXepage();
}

class _MyDatXepage extends State<MyDatXepage>
    with SingleTickerProviderStateMixin {
  List<Tab> lsttab = <Tab>[];
  List<StatefulWidget> lsttabview = <StatefulWidget>[];
  @override
  void initState() {
    super.initState();
    keyword = '';
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Đặt xe',
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
    return SafeArea(
        child: Scaffold(
      // drawer: lstmenu(context),
      appBar: PreferredSize(
        child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: colorbartop,
            leading: new IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  SimpleRouter.back();
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
                      cusSearchBar = Text('Đặt xe',
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
        child: Provider<DatXeblock>(
          child: MyDatXeAllpage(
            requestkeyword: keyword,
            requestblock: new DatXeblock(keyword, 0),
          ),
          create: (context) => new DatXeblock(keyword, 0),
          dispose: (context, bloc) => bloc.dispose(),
        ),
      ),
    ));
  }
}
