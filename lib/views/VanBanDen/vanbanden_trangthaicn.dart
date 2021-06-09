import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
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
TextEditingController _noidung = new TextEditingController();
TextEditingController _hanxuly = new TextEditingController();

class MyTrangThaiVanBanDenCaNhan extends StatefulWidget {
  final id;
  MyTrangThaiVanBanDenCaNhan({this.id});
  @override
  _MyTrangThaiVanBanDenCaNhan createState() =>
      new _MyTrangThaiVanBanDenCaNhan();
}

class _MyTrangThaiVanBanDenCaNhan extends State<MyTrangThaiVanBanDenCaNhan> {
  @override
  void dispose() {
    print('Đóng form trạng thái vb đến cá nhân');
    super.dispose();
  }

  @override
  void initState() {
    selectedValue = 0;
    _noidung.text = '';
    _hanxuly.text = '';
    BlocProvider.of<BlocVanBanDenAction>(context).add(ListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<BlocVanBanDenAction, ActionState>(
      buildWhen: (previousState, state) {
        if (state is DoneState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
          BlocProvider.of<BlocVanBanDenAction>(context).add(ListEvent());
          SimpleRouter.back();
        }
        if (state is ErrorState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
        }
        return;
      },
      builder: (context, state) {
        return SafeArea(
            child: Container(
                child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Cập nhật trạng thái VB',
              style: TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  SimpleRouter.back();
                }),
            backgroundColor: colorbartop,
            actions: <Widget>[_onLoginClick()],
          ),
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                rowlabel('Chọn trạng thái'),
                SearchableDropdown.single(
                  items: [
                    DropdownMenuItem(
                      child: Text("Đã xử lý"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Đang xử lý"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Chưa xử lý"),
                      value: 0,
                    ),
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
                ),
              ],
            ),
          )),
        )));
      },
    ));
  }

  Widget _onLoginClick() {
    // ignore: missing_return
    return BlocBuilder<BlocVanBanDenAction, ActionState>(
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
    if (selectedValue != null) {
      var data = {
        "VanBanID": widget.id,
        "TrangThaiID": selectedValue,
      };
      HoanThanhEvent objEvent = new HoanThanhEvent();
      objEvent.data = data;
      BlocProvider.of<BlocVanBanDenAction>(context).add(objEvent);
    } else
      Toast.show('Bạn chưa chọn trạng thái', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}
