import 'package:app_eoffice/models/DanhMucTenItem.dart';
import 'package:app_eoffice/models/DanhMucXeItem.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/models/ThongTinDatXeGuiNhanItem.dart';
import 'package:app_eoffice/models/ThongTinDatXeItem.dart';
import 'Base_service.dart';

// ignore: camel_case_types
class DatXe_Api {
  Base_service base_service = new Base_service();

  Future<List<ThongTinDatXeItem>> getdatxe(dataquery, currentPage) async {
    try {
      var url = "/datxe/Getthongtindatxe";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => ThongTinDatXeItem.fromMap(f)).toList();
      return lst;
    } catch (e) {
      // return new List<WorkTaskItem>();
      throw Exception('Failed to get data');
    }
  }

  Future<List<NguoiDungItem>> getlaixe(dataquery) async {
    try {
      var url = "/datxe/getlaixe";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
      return lst;
    } catch (e) {
      // return new List<WorkTaskItem>();
      throw Exception('Failed to get data');
    }
  }

  Future<List<DanhMucXeItem>> getdanhmucxe(dataquery) async {
    try {
      var url = "/datxe/getdanhmucxe";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => DanhMucXeItem.fromMap(f)).toList();
      return lst;
    } catch (e) {
      // return new List<WorkTaskItem>();
      throw Exception('Failed to get data');
    }
  }

  Future<List<ThongTinDatXeGuiNhanItem>> getdatxeguinhan(dataquery) async {
    try {
      var url = "/datxe/Getthongtindatxeguinhan";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      var lst = vbData.map((f) => ThongTinDatXeGuiNhanItem.fromMap(f)).toList();
      return lst;
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }

  // lấy chi tiết
  Future<ThongTinDatXeItem> getbyId(dataquery) async {
    try {
      var url = "/datxe/GetByID";
      var vbData = await base_service.getbase(dataquery, url);
      var obj = ThongTinDatXeItem.fromMap(vbData);
      return obj;
    } catch (ex) {
      return new ThongTinDatXeItem();
    }
  }

  // post gửi đặt xe
  Future<dynamic> postsenddatxe(dataquery) async {
    try {
      var url = "/datxe/senddatxe";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  Future<dynamic> postapproveddatxe(dataquery) async {
    try {
      var url = "/datxe/Approved";
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

  Future<dynamic> postReject(dataquery) async {
    try {
      var url = "/datxe/Reject";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }
}
