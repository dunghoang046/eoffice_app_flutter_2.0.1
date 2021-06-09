import 'package:app_eoffice/block/LichlamViecbloc.dart';
import 'package:app_eoffice/models/WeekItem.dart';
import 'package:app_eoffice/models/YearWeekItem.dart';
import 'package:app_eoffice/services/LichLamViec_Api.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/views/LichlamViec/LichlamViec_All.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:simple_router/simple_router.dart';
import 'package:week_of_year/week_of_year.dart';

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

// ignore: must_be_immutable
class MyLichlamViecpage extends StatefulWidget {
  GlobalKey<ScaffoldState> globalKey;
  MyLichlamViecpage({this.globalKey});
  @override
  _MyLichlamViecpage createState() => _MyLichlamViecpage();
}

YearWeekItem searchYearWeekItem = new YearWeekItem();
List<int> lstyear = <int>[];
var yearcurrent = DateTime.now().year;
String yearselect = DateTime.now().year.toString();
int endyear = DateTime.now().year;
int selectedValue = 0;
String weekselect = '0';
// List<DropdownMenuItem> lstdryear = [];
List<DropdownMenuItem<String>> lstdryear = [];
TabController _tabController;

class _MyLichlamViecpage extends State<MyLichlamViecpage>
    with SingleTickerProviderStateMixin {
  List<StatefulWidget> lsttabview = <StatefulWidget>[];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 3);
    final date = DateTime.now();
    print(date.weekOfYear);
    lstdryear = [];
    lstyear = <int>[];
    yearselect = yearcurrent.toString();
    endyear = DateTime.now().year;
    yearcurrent = DateTime.now().year;
    weekselect = date.weekOfYear.toString();
    int startyear = yearcurrent >= 10 ? yearcurrent - 5 : 0;
    if (startyear <= 2019) startyear = 2019;
    for (int i = startyear; i <= endyear; i++) {
      lstyear.add(i);
      lstdryear.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i.toString(),
      ));
    }
    searchYearWeekItem.year = yearcurrent;
    // searchYearWeekItem.week = int.parse(weekselect);
    searchYearWeekItem.week = 13;

    super.initState();
  }

  void gettuannow() async {
    var data = {'year': yearselect};
    var lst = await objlichapi.Getyearweek(data);
    if (lst.length != null && lst.length > 0)
      weekselect = lst.first.week.toString();
  }

  Icon cusIcon = Icon(Icons.search, color: Colors.white);
  Widget cusSearchBar = Text('Lịch làm việc',
      style: TextStyle(
        color: Colors.white,
      ));
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: PreferredSize(
              child: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: colorbartop,
                leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      SimpleRouter.back();
                    }),
                actions: [year()],
                title: cusSearchBar,
              ),
              preferredSize: Size.fromHeight(50),
            ),
            body: DefaultTabController(
              length: 3,
              child: Scaffold(
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
                        new Tab(text: 'Lịch chung'),
                        new Tab(text: 'Lịch đơn vị'),
                        new Tab(text: 'Lịch trường'),
                      ],
                      labelColor: Colors.blue,
                    ),
                  ),
                ),
                body: Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        week(),
                        Expanded(
                            child: Center(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Provider<LichlamViecBloc>(
                                child: MyLichlamViecAllpage(
                                  requestweek: weekselect,
                                  requesyear: yearselect,
                                  requestblock: new LichlamViecBloc(
                                      yearselect, weekselect, 0),
                                ),
                                create: (context) => new LichlamViecBloc(
                                    yearselect, weekselect, 0),
                                dispose: (context, bloc) => bloc.dispose(),
                              ),
                              Provider<LichlamViecBloc>(
                                child: MyLichlamViecAllpage(
                                  requestweek: weekselect,
                                  requesyear: yearselect,
                                  requestblock: new LichlamViecBloc(
                                      yearselect, weekselect, 2),
                                ),
                                create: (context) => new LichlamViecBloc(
                                    yearselect, weekselect, 2),
                                dispose: (context, bloc) => bloc.dispose(),
                              ),
                              Provider<LichlamViecBloc>(
                                child: MyLichlamViecAllpage(
                                  requestweek: weekselect,
                                  requesyear: yearselect,
                                  requestblock: new LichlamViecBloc(
                                      yearselect, weekselect, 1),
                                ),
                                create: (context) => new LichlamViecBloc(
                                    yearselect, weekselect, 1),
                                dispose: (context, bloc) => bloc.dispose(),
                              ),
                            ],
                          ),
                        )),
                      ],
                    )),
              ),
            )));
  }

  LichlamViec_Api objlichapi = new LichlamViec_Api();
  Widget week() {
    var data = {'year': yearselect};
    return FutureBuilder(
        future: objlichapi.gettuan(data),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<WeekItem> list = <WeekItem>[];
          if (snapshot.hasData) list = snapshot.data;
          if (list != null && list.length > 0) {
            List<DropdownMenuItem> lst = [];
            for (var i = 0; i < list.length; i++) {
              lst.add(DropdownMenuItem(
                child: Text(list[i].rance),
                value: list[i].id.toString(),
              ));
            }
            return SearchableDropdown.single(
              items: lst,
              value: weekselect,
              hint: "Chọn tuần",
              searchHint: "Chọn tuần",
              onChanged: (value) {
                setState(() {
                  weekselect = value;
                  searchYearWeekItem.week = int.parse(weekselect);
                });
              },
              isExpanded: true,
              // dialogBox: false,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget year() {
    return Container(
      // color: Colors.yellow,
      margin: EdgeInsets.fromLTRB(0, 0, 45, 0),
      child: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.blue,
            primaryColor: Colors.blue,
            backgroundColor: Colors.black),
        child: DropdownButton<String>(
          value: yearselect,
          items: lstdryear,
          focusColor: Colors.black,
          iconEnabledColor: Colors.white,
          dropdownColor: Colors.blue,
          style: TextStyle(color: Colors.white, fontSize: 18),
          onChanged: (String value) {
            setState(() => yearselect = value);
          },
        ),
      ),
    );
  }
}
