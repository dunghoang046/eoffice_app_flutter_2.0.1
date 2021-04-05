import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

List<DropdownMenuItem> lst = [];
int selectedValue;
TextEditingController _noidung = new TextEditingController();
TextEditingController _hanxuly = new TextEditingController();

class MyTrangThaiVanBanDen extends StatefulWidget {
  final id;
  MyTrangThaiVanBanDen({this.id});
  @override
  _MyTrangThaiVanBanDen createState() => new _MyTrangThaiVanBanDen();
}

class _MyTrangThaiVanBanDen extends State<MyTrangThaiVanBanDen> {
  @override
  void dispose() {
    print('Đóng form trạng thái vb đến');
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
                      child: Text("Chọn trạng thái"),
                      value: 0,
                    ),
                    DropdownMenuItem(
                      child: Text("Đã xử lý"),
                      value: 3,
                    ),
                    DropdownMenuItem(
                      child: Text("Đang xử lý"),
                      value: 2,
                    ),
                    DropdownMenuItem(
                      child: Text("Chờ xử lý"),
                      value: 4,
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
                rowlabel('Nội dung'),
                TextFormField(
                  controller: _noidung,
                  decoration: InputDecoration(hintText: 'Nhập nội dung'),
                  onChanged: (value) {
                    setState(() {
                      _noidung.text = value;
                    });
                  },
                ),
                rowlabel('Hạn xử lý'),
                HanXuLy(),
              ],
            ),
          )),
        )));
      },
    ));
  }

  Widget _onLoginClick() {
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
    if (selectedValue != null && selectedValue > 0) {
      var data = {
        "VanBanID": widget.id,
        "TrangThaiID": selectedValue,
        "NoiDung": _noidung.text,
        "HanXuLy": _hanxuly.text,
      };
      FinshEvent addEvent = new FinshEvent();
      addEvent.data = data;
      BlocProvider.of<BlocVanBanDenAction>(context).add(addEvent);
    } else
      Toast.show('Bạn chưa chọn trạng thái', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}

class HanXuLy extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _hanxuly,
        decoration: InputDecoration(
            hintText: "Ngày bắt đầu",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: Colors.black45, width: 5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.grey[200],
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: Colors.grey[200],
              ),
            ),
            labelText: 'Hạn xử lý'),
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              confirmText: 'Chọn',
              cancelText: 'Hủy');
        },
      ),
    ]);
  }
}
