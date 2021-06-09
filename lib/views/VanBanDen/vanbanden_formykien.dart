import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_DonViNhan.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_NhomNguoiNhan.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_nguoinhan.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/LookupItem.dart';
import 'package:app_eoffice/services/Base_service.dart';
import 'package:app_eoffice/services/DonVi_Api.dart';
import 'package:app_eoffice/services/NguoiDung_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/utils/quyenhan.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/ComBo_DonViPhoiHop.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/Combo_lanhdaotrinh.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_lanhdaobutphe.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_nguoiXuLy.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combo_nguoiphoihop.dart';
import 'package:app_eoffice/widget/vanbanden/vanbandenykien/combox_DonviDauMoi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';
import 'package:simple_router/simple_router.dart';

class MyVanBanDenYKienForm extends StatefulWidget {
  final int id;
  MyVanBanDenYKienForm({@required this.id});

  @override
  _MyVanBanDenYKienForm createState() => new _MyVanBanDenYKienForm();
}

NguoiDung_Api nndApi = new NguoiDung_Api();
DonVi_Api dvApi = new DonVi_Api();
Future<List<LookupItem>> lstlanhdao;
TextEditingController _hanxuly = new TextEditingController();
TextEditingController _noidung = new TextEditingController();
var dataquery = {
  "Chucvu": '2,3,4,6',
  "DonViID": '' + nguoidungsessionView.donviid.toString() + ''
};

class _MyVanBanDenYKienForm extends State<MyVanBanDenYKienForm> {
  void initState() {
    BlocProvider.of<BlocVanBanDenAction>(context).add(NoEven());
    super.initState();
    _noidung.text = '';
    _hanxuly.text = '';
    loaddata();
  }

  void loaddata() async {
    var lstnguoidung = await nndApi.getnguoidungbychucvu(dataquery);
    lstlanhdao = getlookupnguoidung(lstnguoidung);
  }

  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
            child: BlocBuilder<BlocVanBanDenAction, ActionState>(
                buildWhen: (previousState, state) {
      if (state is DoneState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
        BlocProvider.of<BlocVanBanDenAction>(context).add(ViewYKienEvent());
        SimpleRouter.back();
      }
      if (state is ErrorState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
      }
      return;
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Ý kiến văn bản đến',
            style: TextStyle(color: Colors.white),
          ),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.pop(context);
                SimpleRouter.back();
              }),
          actions: [_onLoginClick()],
          backgroundColor: colorbartop,
        ),
        body: SingleChildScrollView(
            child: Theme(
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
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      rowlabel('Trình lãnh đạo'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      MyComBo_Lanhdaotrinh(),
                    if (checkquyen(
                        nguoidungsession.quyenhan, QuyenHan().VanthuDonvi))
                      rowlabel('Lãnh đạo bút phê'),
                    if (checkquyen(
                        nguoidungsession.quyenhan, QuyenHan().VanthuDonvi))
                      MyComBo_Lanhdaobutphe(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      rowlabel('Đơn vị đầu mối'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      MyComBo_DonViDauMoi(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      rowlabel('Đơn vị phối hợp'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      MyComBo_DonViPhoiHop(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      rowlabel('Đơn vị nhận'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(
                            nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      MyComBo_DonViNhan(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      rowlabel('Người xử lý'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      MyComBo_NguoiXuLy(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      rowlabel('Người phối hợp'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      MyComBo_NguoiphoiHop(),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      rowlabel('Người nhận'),
                    if (checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaodonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().VanthuDonvi) ||
                        checkquyen(nguoidungsession.quyenhan,
                            QuyenHan().Lanhdaophongban))
                      MyComBo_NguoiNhan(),
                    if (checkquyen(
                        nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      rowlabel('Nhóm người nhận'),
                    if (checkquyen(
                        nguoidungsession.quyenhan, QuyenHan().Lanhdaodonvi))
                      MyComBo_NhomNguoiNhan(),
                    rowlabel('Nội dung'),
                    MyTextForm(
                      text_hind: 'Nội dung',
                      noidung: _noidung,
                    ),
                    rowlabel('Hạn xử lý'),
                    BasicDateField(),
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
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
              accentColor: Colors.blue,
              primaryColor: Colors.blue),
        )),
      );
    })));
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
          mOnPressed: () => {_clickykien()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Cập nhật',
          mOnPressed: () => _clickykien(),
        );
        // }
      }
    });
  }

  void _clickykien() {
    if ((_noidung.text == null || _noidung.text == '') &&
        (lstlanhdaotrinh == null ||
            (lstlanhdaotrinh != null && lstlanhdaotrinh.length <= 0)) &&
        (ltsLanhDao == null ||
            (ltsLanhDao != null && ltsLanhDao.length <= 0)) &&
        (lstDonViDauMoi == null ||
            (lstDonViDauMoi != null && lstDonViDauMoi.length <= 0)) &&
        (lstDonViPhoiHop == null ||
            (lstDonViPhoiHop != null && lstDonViPhoiHop.length <= 0)) &&
        (lstNguoiDauMoi == null ||
            (lstNguoiDauMoi != null && lstNguoiDauMoi.length <= 0)) &&
        (lstNguoiPhoiHop == null ||
            (lstNguoiPhoiHop != null && lstNguoiPhoiHop.length <= 0)) &&
        (lstNguoinhan == null ||
            (lstNguoinhan != null && lstNguoinhan.length <= 0)) &&
        (lstnhomnguoinhan == null ||
            (lstnhomnguoinhan != null && lstnhomnguoinhan.length <= 0)) &&
        (_hanxuly.text == null || _hanxuly.text == '')) {
      Toast.show('Bạn chưa nhập thông tin ', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
    } else {
      var data = {
        "VanBanID": widget.id,
        "NoiDung": _noidung.text,
        "LtsTrinhLanhDao": lstlanhdaotrinh,
        "LtsLanhDao": ltsLanhDao,
        "LstDonViDauMoi": lstDonViDauMoi,
        "LstDonViPhoiHop": lstDonViPhoiHop,
        "LstNguoiDauMoi": lstNguoiDauMoi,
        "LstNguoiPhoiHop": lstNguoiPhoiHop,
        "LstDonViNhan": lstDonVinhan,
        "LstNguoiNhan": lstNguoinhan,
        "LstNhomNguoiNhan": lstnhomnguoinhan,
        "HanXuLy": _hanxuly.text
      };
      YKienEvent yKienEvent = new YKienEvent();
      yKienEvent.data = data;
      BlocProvider.of<BlocVanBanDenAction>(context).add(yKienEvent);
    }
  }
}

class BasicDateField extends StatelessWidget {
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
              confirmText: 'Chọn',
              cancelText: 'Hủy');
        },
      ),
    ]);
  }
}
