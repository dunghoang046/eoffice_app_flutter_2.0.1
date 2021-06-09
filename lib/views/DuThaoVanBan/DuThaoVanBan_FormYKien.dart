import 'package:app_eoffice/block/DuThaoVanBanblock.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/views/DuThaoVanBan/Trinh/combo_NguoiNhan.dart';
import 'package:app_eoffice/views/DuThaoVanBan/Trinh/combo_NhomDonVi.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/Combo_PhongBanLienQuan.dart';
import 'package:app_eoffice/widget/DuThaoVanBan/Trinh/Combo_canbolienquan.dart';
import 'package:app_eoffice/widget/vanbandi/VanBanDiGuiNhan/Combo_Nguoidung.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class MyDuThaoVanBanYKienForm extends StatefulWidget {
  final int id;
  MyDuThaoVanBanYKienForm({@required this.id});

  @override
  _MyDuThaoVanBanYKienForm createState() => new _MyDuThaoVanBanYKienForm();
}

TextEditingController _noidung = new TextEditingController();

TextEditingController _hanxuly = new TextEditingController();

class _MyDuThaoVanBanYKienForm extends State<MyDuThaoVanBanYKienForm> {
  @override
  // ignore: must_call_super
  void initState() {
    _noidung.text = '';
    _hanxuly.text = '';
    BlocProvider.of<BlocDuThaoVanBanAction>(context).add(NoEven());
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Scaffold(
            backgroundColor: Colors.grey[350],
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                'Thêm ý kiến',
                style: TextStyle(color: Colors.white),
              ),
              leading: new IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    SimpleRouter.back();
                  }),
              actions: [_onLoginClick()],
              backgroundColor: colorbartop,
            ),
            body: SingleChildScrollView(
                child: BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
                    buildWhen: (previousState, state) {
              if (state is DoneState) {
                Toast.show(basemessage, context,
                    duration: 2,
                    gravity: Toast.TOP,
                    backgroundColor: Colors.green);
                BlocProvider.of<BlocDuThaoVanBanAction>(context)
                    .add(ViewYKienEvent());
                SimpleRouter.back();
              }
              if (state is ErrorState) {
                Toast.show(basemessage, context,
                    duration: 2,
                    gravity: Toast.TOP,
                    backgroundColor: Colors.red);
              }
              return;
            }, builder: (context, state) {
              return Theme(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 8.0),
                        spreadRadius: 5,
                        blurRadius: 7,
                        // offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  // color: Colors.white,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Form(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      rowlabelValidate('Nội dung'),
                      MyTextForm(
                        text_hind: 'Nội dung',
                        noidung: _noidung,
                      ),
                      rowlabel('Người nhận'),
                      MyComBo_NguoiNhan(),
                      rowlabel('Cán bộ liên quan'),
                      MyComBo_CanBoLienQuan(),
                      rowlabel('Phòng ban liên quan'),
                      MyComBo_PhongBanLienQuan(),
                      rowlabel('Nhóm đơn vị'),
                      MyComBo_NhomDonVi(),
                      rowlabel('Hạn xử lý'),
                      HanXuLy(),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                              child: MaterialButton(
                                  // padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  onPressed: () {
                                    SimpleRouter.back();
                                  },
                                  color: Colors.red,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.close,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Hủy',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: white),
                                      ),
                                    ],
                                  ))),
                        ],
                      )
                    ],
                  )),
                ),
                data: ThemeData(
                    buttonTheme:
                        ButtonThemeData(textTheme: ButtonTextTheme.accent),
                    accentColor: Colors.blue,
                    primaryColor: Colors.blue),
              );
            }))));
  }

  Widget _onLoginClick() {
    return BlocBuilder<BlocDuThaoVanBanAction, ActionState>(
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
          label: 'Ý kiến',
          mOnPressed: () => {_clickykien()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Ý kiến',
          mOnPressed: () => _clickykien(),
        );
        // }
      }
    });
  }

  void _clickykien() {
    if ((lstnguoidung == null || (lstnguoidung.length <= 0)) &&
        (_noidung.text == null || (_noidung.text.length <= 0)) &&
        (lstnguoidung == null || (lstnguoidung.length <= 0)) &&
        (lstphongbanlienquan == null || (lstphongbanlienquan.length <= 0)) &&
        (lstnhomdonvi == null || (lstnhomdonvi.length <= 0))) {
      Toast.show('Bạn chưa nhập thông tin  ', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
    } else {
      var data = {
        "VanBanID": widget.id,
        "NoiDung": _noidung.text,
        "HanXuLy": _hanxuly.text,
        "NguoiNhanVanBan": lstnguoinhan,
        "CanBoLienQuan": lstcanbolienquan,
        "PhongBanDonViLienQuan": lstphongbanlienquan,
        "NhomDonViLienQuan": lstnhomdonvi
      };
      YKienEvent yKienEvent = new YKienEvent();
      yKienEvent.data = data;
      BlocProvider.of<BlocDuThaoVanBanAction>(context).add(yKienEvent);
    }
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
            // hintText: "Nội dung",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(10.0),
              borderSide: new BorderSide(color: Colors.black, width: 5),
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
            // confirmText: 'Chọn',
            // cancelText: 'Hủy'
          );
        },
      ),
    ]);
  }
}
