import 'package:app_eoffice/models/DanhMucTenItem.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/models/WorkTaskCommentItem.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'Base_service.dart';

// ignore: camel_case_types
class CongViec_Api {
  Base_service base_service = new Base_service();

  Future<List<WorkTaskItem>> getcongviec(dataquery, currentPage) async {
    try {
      var url = "/CongViec/GetAllCongViec";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => WorkTaskItem.fromMap(f)).toList();
      return lst;
    } catch (e) {
      // return new List<WorkTaskItem>();
      throw Exception('Failed to get data');
    }
  }

  // lấy chi tiết
  Future<WorkTaskItem> getbyId(dataquery) async {
    try {
      var url = "/CongViec/GetByID";
      var vbData = await base_service.getbase(dataquery, url);
      var obj = WorkTaskItem.fromMap(vbData);
      return obj;
    } catch (ex) {
      return new WorkTaskItem();
    }
  }

// lấy ý kiến
  Future<List<WorkTaskCommentItem>> getcomment(dataquery) async {
    try {
      var url = "/CongViec/Getcomment";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => WorkTaskCommentItem.fromMap(f)).toList();
      return lst;
    } catch (ex) {
      return <WorkTaskCommentItem>[];
    }
  }

  // post thành phần tham gia
  Future<dynamic> postaddcongviec(dataquery) async {
    try {
      var url = "/CongViec/add";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  // post ý kiến
  Future<dynamic> postykien(dataquery) async {
    try {
      var url = "/CongViec/AddComment";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  // post thành phần tham gia
  Future<dynamic> postaddthanhphan(dataquery) async {
    try {
      var url = "/CongViec/AddUserPerform";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  Future<dynamic> postfinsh(dataquery) async {
    try {
      var url = "/CongViec/Finish";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  Future<dynamic> postuploadfile(dataquery, donviid) async {
    try {
      var url = "/CongViec/UploadJsonFile?DonViID=" + donviid;
      var lstfile = await base_service.post(dataquery, url);
      return lstfile;
    } catch (ex) {
      return ex;
    }
  }

  Future<List<NhomNguoiDungItem>> getnhomnguoidung() async {
    try {
      var url = "/CongViec/Getnhomnguoidung";
      List<dynamic> vbData = await base_service.getbase(null, url);
      var lst = vbData.map((f) => NhomNguoiDungItem.fromMap(f)).toList();
      return lst;
    } catch (ex) {
      return <NhomNguoiDungItem>[];
    }
  }

  Future<List<DonViItem>> getdonvi() async {
    try {
      var url = "/CongViec/Getdonvi";
      List<dynamic> vbData = await base_service.getbase(null, url);
      var lst = vbData.map((f) => DonViItem.fromMap(f)).toList();
      return lst;
    } catch (ex) {
      return ex;
    }
  }

  Future<List<NguoiDungItem>> getnguoidung() async {
    try {
      var url = "/CongViec/Getnguoidung";
      List<dynamic> vbData = await base_service.getbase(null, url);
      var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
      return lst;
    } catch (ex) {
      return <NguoiDungItem>[];
    }
  }

  Future<List<DanhMucTenItem>> getdanhmuc() async {
    try {
      var url = "/CongViec/Getdanhmuc";
      List<dynamic> vbData = await base_service.getbase(null, url);
      var lst = vbData.map((f) => DanhMucTenItem.fromMap(f)).toList();
      return lst;
    } catch (ex) {
      return <DanhMucTenItem>[];
    }
  }
}
