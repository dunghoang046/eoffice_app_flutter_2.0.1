import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/DatXeBloc.dart';
import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/models/DanhMucTenItem.dart';
import 'package:app_eoffice/models/DanhMucXeItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/services/DatXe_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/Base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

List<DropdownMenuItem> lst = [];
Future<List<NguoiDungItem>> lstlaixe;
Future<List<DanhMucXeItem>> lstxe;
String laixeid;
String xeid;
DatXe_Api objApi = new DatXe_Api();
int selectedValue;

class MyFormApproved extends StatefulWidget {
  final id;
  MyFormApproved({this.id});
  _MyFormApproved createState() => _MyFormApproved();
}

class _MyFormApproved extends State<MyFormApproved> {
  @override
  void initState() {
    laixeid = '0';
    xeid = '0';
    // BackButtonInterceptor.add(myInterceptor);
    selectedValue = 0;
    loaddata();
    super.initState();
  }

  @override
  void dispose() {
    print('Đóng form trạng thái');
    super.dispose();
  }

  void loaddata() {
    if (widget.id != null && widget.id > 0) {
      var dataquery = {"ID": '' + widget.id.toString() + ''};
      setState(() {
        lstlaixe = objApi.getlaixe(dataquery);
        lstxe = objApi.getdanhmucxe(dataquery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<BlocDatXeAction, ActionState>(
            buildWhen: (previousState, state) {
      if (state is DoneState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
        SimpleRouter.back();
      }
      if (state is ErrorState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
      }
      return;
    }, builder: (context, state) {
      return SafeArea(
          child: Container(
              // margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Duyệt đặt xe',
            style: TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                SimpleRouter.back();
              }),
          backgroundColor: colorbartop,
          actions: <Widget>[_onLoginClick1()],
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: lstlaixe,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Đã có lỗi xảy ra'),
                    );
                  }
                  if (snapshot.hasData) {
                    List<NguoiDungItem> list = snapshot.data;
                    if (list.length > 0) {
                      List<DropdownMenuItem> lst = [];
                      for (var i = 0; i < list.length; i++) {
                        lst.add(DropdownMenuItem(
                          child: Text(list[i].tenhienthi),
                          value: list[i].id.toString(),
                        ));
                      }
                      return SearchableDropdown.single(
                        items: lst,
                        value: laixeid,
                        hint: "Chọn lái xe",
                        searchHint: null,
                        onChanged: (value) {
                          setState(() {
                            laixeid = value;
                          });
                        },
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints:
                            BoxConstraints.tight(Size.fromHeight(350)),
                      );
                    } else
                      return notrecord();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: lstxe,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Đã có lỗi xảy ra'),
                    );
                  }
                  if (snapshot.hasData) {
                    List<DanhMucXeItem> list = snapshot.data;
                    if (list.length > 0) {
                      List<DropdownMenuItem> lst = [];
                      for (var i = 0; i < list.length; i++) {
                        lst.add(DropdownMenuItem(
                          child: Text(list[i].ten),
                          value: list[i].id.toString(),
                        ));
                      }
                      return SearchableDropdown.single(
                        items: lst,
                        value: xeid,
                        hint: "Chọn xe",
                        searchHint: null,
                        onChanged: (value) {
                          setState(() {
                            xeid = value;
                          });
                        },
                        dialogBox: false,
                        isExpanded: true,
                        menuConstraints:
                            BoxConstraints.tight(Size.fromHeight(350)),
                      );
                    } else
                      return notrecord();
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        )),
      )));
    }));
  }

  Widget _onLoginClick1() {
    // ignore: missing_return
    return BlocBuilder<BlocDatXeAction, ActionState>(builder: (context, state) {
      if (state is LoadingState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          label: 'Đang xử lý ...',
          mOnPressed: () => {},
        );
      } else if (state is ErrorState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.approval,
          label: 'Duyệt',
          mOnPressed: () => {_click_add()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.approval,
          label: 'Duyệt',
          mOnPressed: () => _click_add(),
        );
        // }
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _click_add() {
    if (xeid != null && xeid != "0" && laixeid != null && laixeid != "0") {
      var data = {
        "DatXeID": widget.id,
        "LaiXeID": laixeid,
        "XeID": xeid,
      };
      ApproverEvent addEvent = new ApproverEvent();
      addEvent.data = data;
      BlocProvider.of<BlocDatXeAction>(context).add(addEvent);
    } else
      Toast.show('Bạn chưa chọn thông tin', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}
