import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

List<DropdownMenuItem> lst = [];

int selectedValue;

class MyFormTrangThaiCongViec extends StatefulWidget {
  final id;
  MyFormTrangThaiCongViec({this.id});
  _MyFormTrangThaiCongViec createState() => _MyFormTrangThaiCongViec();
}

class _MyFormTrangThaiCongViec extends State<MyFormTrangThaiCongViec> {
  @override
  void initState() {
    // BackButtonInterceptor.add(myInterceptor);
    selectedValue = 0;
    super.initState();
  }

  @override
  void dispose() {
    print('Đóng form trạng thái');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<BlocCongViecAction, ActionState>(
            buildWhen: (previousState, state) {
      if (state is ViewState) {
        // Toast.show(basemessage, context,
        //     duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
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
              margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
              child: Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'Cập nhật trạng thái',
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
                    child: SearchableDropdown.single(
                  items: [
                    DropdownMenuItem(
                      child: Text("Chọn trạng thái"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Hoàn thành"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Tạm dừng"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Hủy"),
                      value: 4,
                    ),
                    // DropdownMenuItem(
                    //   child: Text("Làm lại"),
                    //   value: 1,
                    // )
                  ],
                  value: selectedValue,
                  hint: "Chọn trạng thái",
                  searchHint: "Chọn trạng thái",
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                  // dialogBox: false,
                )),
              )));
    }));
  }

  Widget _onLoginClick1() {
    // ignore: missing_return
    return BlocBuilder<BlocCongViecAction, ActionState>(
        builder: (context, state) {
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
          icons: Icons.save,
          label: 'Cập nhật',
          mOnPressed: () => {_click_add()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Cập nhật',
          mOnPressed: () => _click_add(),
        );
        // }
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _click_add() {
    if (selectedValue != null && selectedValue > 0) {
      var data = {
        "CongViecID": widget.id,
        "TrangThaiID": selectedValue,
      };
      FinshEvent addEvent = new FinshEvent();
      addEvent.data = data;
      BlocProvider.of<BlocCongViecAction>(context).add(addEvent);
    } else
      Toast.show('Bạn chưa chọn trạng thái', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}
