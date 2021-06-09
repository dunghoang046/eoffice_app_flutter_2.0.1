import 'package:app_eoffice/block/CongViecBloc.dart';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:app_eoffice/widget/CongViec/ThanhPhanThamGia/select_donvi.dart';
import 'package:app_eoffice/widget/CongViec/ThanhPhanThamGia/select_nguoidung.dart';
import 'package:app_eoffice/widget/CongViec/ThanhPhanThamGia/select_nhomnguoidung.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/ModelForm/DanhMucCongViecItem.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/TextForm.dart';
import 'package:app_eoffice/widget/CongViec/ThemMoi/combo_DanhMuc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:date_format/date_format.dart';
import 'package:file_picker/file_picker.dart';
import 'package:app_eoffice/models/FileAttachItem.Dart';
import 'package:app_eoffice/services/Base_service.dart';

dynamic lstfile;

class MyThemMoiCongViec extends StatefulWidget {
  final int id;
  final parentID;
  final List<int> lstselect;

  MyThemMoiCongViec({@required this.id, this.lstselect, this.parentID});

  @override
  _MyThemMoiCongViec createState() => new _MyThemMoiCongViec();
}

Future<List<NhomNguoiDungItem>> objlanhdaotrinh;
Future<List<DonViItem>> lstdonvi;
Future<List<NguoiDungItem>> lstnguoidung;
CongViec_Api objapi = new CongViec_Api();
TextEditingController _noidung = new TextEditingController();
TextEditingController _mota = new TextEditingController();
TextEditingController _ngaybatdau = new TextEditingController();
TextEditingController _ngayketthuc = new TextEditingController();
TextEditingController _tags = new TextEditingController();
Future<WorkTaskItem> obj;
WorkTaskItem objcvadd = new WorkTaskItem();

class _MyThemMoiCongViec extends State<MyThemMoiCongViec> {
  // ignore: must_call_super
  void initState() {
    lstfiledinhkem = new List<FileAttachItem>();
    loaddata();

    if (widget.id <= 0) {
      _noidung.text = '';
      _mota.text = '';
      _ngaybatdau.text = '';
      _ngayketthuc.text = '';
      _tags.text = '';
    }
    BlocProvider.of<BlocCongViecAction>(context).add(ListEvent());
  }

  String filename = '';
  String progress = '';
  List<FileAttachItem> lstfiledinhkem;
  final _formKeyadd = GlobalKey<FormState>();
  Future<DanhMucCongViecItem> getdanhmuc() async {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    DanhMucCongViecItem objnd = new DanhMucCongViecItem();
    objnd.lstdanhmuc = await objapi.getdanhmuc();
    if (widget.id > 0)
      objnd.obj = await objapi.getbyId(dataquery);
    else
      objnd.obj = new WorkTaskItem();
    return objnd;
  }

  void loaddata() async {
    var dataquery = {"ID": '' + widget.id.toString() + ''};
    if (widget.id != null && widget.id > 0) {
      obj = objapi.getbyId(dataquery);
      objcvadd = await objapi.getbyId(dataquery);
      _noidung.text = objcvadd.title;
      setState(() {
        lstfiledinhkem = objcvadd.lstfile;
      });
      if (objcvadd.startDate != null)
        _ngaybatdau.text = formatDate(
            DateTime.parse(objcvadd.startDate), [dd, '/', mm, '/', yyyy]);
      if (objcvadd.endDate != null)
        _ngayketthuc.text = formatDate(
            DateTime.parse(objcvadd.endDate), [dd, '/', mm, '/', yyyy]);
    }
  }

  FilePickerResult selectedfile;
  selectFile() async {
    selectedfile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'docx', 'xlsx', 'xls'],
    );
    if (selectedfile != null) {
      PlatformFile file = selectedfile.files.first;
      filename = file.name;
      List<MultipartFile> lstfiles = <MultipartFile>[];
      for (var i = 0; i < selectedfile.files.length; i++) {
        lstfiles.add(
          MultipartFile.fromFileSync(selectedfile.files[i].path,
              filename: selectedfile.files[i].name),
        );
      }

      FormData formdatafile = FormData.fromMap({'files': lstfiles});
      String uploadurl = new Base_service().baseUrl +
          "/CongViec/UploadJsonFile?DonViID=" +
          nguoidungsessionView.donviid.toString();
      Dio dio = new Dio();
      var response = await dio.post(
        uploadurl,
        data: formdatafile,
        onSendProgress: (int sent, int total) {
          setState(() {});
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> vbData = response.data['Data'];
        var lst = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
        setState(() {
          lstfiledinhkem.addAll(lst);
        });
      } else {
        print("Có lỗi xảy ra do server");
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: BlocBuilder<BlocCongViecAction, ActionState>(
            buildWhen: (previousState, state) {
      if (state is DoneState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
        BlocProvider.of<BlocCongViecAction>(context).add(ListEvent());
        SimpleRouter.back();
      }
      if (state is ErrorState) {
        Toast.show(basemessage, context,
            duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
      }
      return;
    }, builder: (context, state) {
      return KeyboardDismisser(
          child: SafeArea(
              child: Scaffold(
                  backgroundColor: Colors.grey[350],
                  appBar: AppBar(
                    iconTheme: IconThemeData(color: Colors.white),
                    title: Text(
                      widget.id > 0
                          ? 'Cập nhật công việc'
                          : 'Thêm mới công việc',
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
                          key: _formKeyadd,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              rowlabel('Tên công việc'),
                              MyTextForm(
                                text_hind: 'Tên công việc',
                                noidung: _noidung,
                                isvalidate: true,
                              ),
                              rowlabel('Bắt đầu'),
                              NgayBatDau(),
                              rowlabel('Kết thúc'),
                              NgayKetThuc(),
                              Myselect_NhomNguoiDung(obj, widget.id),
                              Myselect_DonVi(
                                objword: obj,
                                id: widget.id,
                              ),
                              MySelect_NguoiDung(obj, widget.id),
                              MyComBo_Danhmuc(lstdm: getdanhmuc()),
                              rowlabel('Tags'),
                              MyTextForm(
                                text_hind: 'Tags',
                                noidung: _tags,
                                isvalidate: false,
                              ),
                              rowlabel('Mô tả'),
                              MyTextForm(
                                text_hind: 'Mô tả',
                                noidung: _mota,
                                isvalidate: false,
                              ),

                              // ignore: deprecated_member_use
                              RaisedButton.icon(
                                onPressed: () {
                                  selectFile();
                                },
                                icon: Icon(
                                  Icons.folder_open,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  "Chọn file",
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Colors.red,
                                // colorBrightness: Brightness.light,
                              ),
                              if (lstfiledinhkem != null)
                                for (int i = 0; i < lstfiledinhkem.length; i++)
                                  InkWell(
                                    child: Row(
                                      children: [
                                        Text(lstfiledinhkem[i].ten),
                                        Icon(Icons.delete)
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        lstfiledinhkem.removeAt(i);
                                      });
                                    },
                                  ),
                            ],
                          )),
                    ),
                    data: ThemeData(
                        buttonTheme:
                            ButtonThemeData(textTheme: ButtonTextTheme.accent),
                        accentColor: Colors.blue,
                        primaryColor: Colors.blue),
                  )))));
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
    if (_formKeyadd.currentState.validate()) {
      var data = {
        "ID": widget.id,
        "Title": _noidung.text,
        "StartDate": _ngaybatdau.text,
        "EndDate": _ngayketthuc.text,
        "UserPerform": lstnguoidungthuchien.toSet().toList(),
        "UserFollow": lstnguoidungtheodoi.toSet().toList(),
        "GroupPerform": lstdonvithuchien.toSet().toList(),
        "GroupFollow": lstdonvitheodoi.toSet().toList(),
        "UserGroupPerform": lstnhomnguoithuchien.toSet().toList(),
        "UserGroupFollow": lstnhomnguoitheodoi.toSet().toList(),
        "Description": _mota.text,
        "ParentID": widget.parentID,
        "DanhMucGiaTriID":
            lstdanhmucgiatri.length > 0 ? lstdanhmucgiatri.join(',') : '',
        "lstfile": lstfiledinhkem != null && lstfiledinhkem.length > 0
            ? lstfiledinhkem.map((e) => e.toJson()).toList()
            : null
      };
      AddEvent addEvent = new AddEvent();
      addEvent.data = data;
      BlocProvider.of<BlocCongViecAction>(context).add(addEvent);
    }
  }
}

class NgayKetThuc extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _ngayketthuc,
        initialValue:
            objcvadd.endDate != null ? DateTime.parse(objcvadd.endDate) : '',
        decoration: InputDecoration(
            hintText: "Ngày kết thúc",
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
            labelText: 'Ngày kết thúc'),
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
        // ignore: missing_return
        validator: (value) {
          if (value == null) return 'Vui lòng nhập dữ liệu';
        },
      ),
    ]);
  }
}

class NgayBatDau extends StatelessWidget {
  final format = DateFormat("dd/MM/yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        controller: _ngaybatdau,
        initialValue: objcvadd.startDate != null
            ? DateTime.parse(objcvadd.startDate)
            : '',
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
            labelText: 'Ngày bắt đầu'),
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
        // ignore: missing_return
        validator: (value) {
          if (value == null) return 'Vui lòng nhập dữ liệu';
        },
      ),
    ]);
  }
}
