import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/models/LanhDaoTrinhDTItem.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:app_eoffice/models/VanBanDiYKienItem.dart';
import 'Base_service.dart';

class DuThaoVanBan_api {
  Base_service base_service = new Base_service();
  List<DuThaoVanBanItem> lstvanbandi = <DuThaoVanBanItem>[];
  int currentPageNow = 1;
  int total = 0;
  // lấy tất cả dữ liệu
  Future<List<DuThaoVanBanItem>> getvanban(dataquery, currentPage) async {
    var url = "/VanBanDuThao/GetAllVanBan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstvanbandi = vbData.map((f) => DuThaoVanBanItem.fromMap(f)).toList();
    return lstvanbandi;
  }

// lấy tất cả dữ liệu
  Future<List<VanBanDiYKienItem>> getykienbyvanban(dataquery) async {
    var url = "/VanBanDuThao/Getykien";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDiYKienItem.fromMap(f)).toList();
    return lst;
  }

// lấy chi tiết bản ghi
  Future<DuThaoVanBanItem> getbyId(dataquery) async {
    var url = "/VanBanDuThao/GetByID";
    var vbData = await base_service.getbase(dataquery, url);
    var obj = DuThaoVanBanItem.fromMap(vbData);
    return obj;
  }

  // Future<List<VanBanDiGuiNhanItem>>  getduthaovanbanguinhan(dataquery) async {
  //   var url = "/VanBanDuThao/Getthongtinguinhanvanban";
  //   var vbData = await base_service.getbase(dataquery, url);
  //    var lst = vbData.map((f) => VanBanDiGuiNhanItem.fromMap(f)).toList();
  //   return lst;
  // }

  Future<List<VanBanDiGuiNhanItem>> getduthaovanbanguinhan(dataquery) async {
    var url = "/VanBanDuThao/Getthongtinguinhanvanban";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lstguinhan = vbData.map((f) => VanBanDiGuiNhanItem.fromMap(f)).toList();
    return lstguinhan;
  }

// lấy lãnh đạo trình
  Future<LanhDaoTrinhDTItem> getlanhdaotrinh(dataquery) async {
    var url = "/VanBanDuThao/Getlanhdaotrinh";
    var vbData = await base_service.getbase(dataquery, url);
    var obj = LanhDaoTrinhDTItem.fromMap(vbData);
    return obj;
  }

// lấy danh sách phòng ban liên quan
  Future<List<DonViItem>> getphongbanlienquan() async {
    var url = "/VanBanDuThao/Getphongbanlienquan";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => DonViItem.fromMap(f)).toList();
    return lst;
  }

  Future<List<NguoiDungItem>> getcanbolienquan() async {
    var url = "/VanBanDuThao/Getnguoidungdonvi";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    return lst;
  }

  Future<List<NhomNguoiDungItem>> getnhomdonvi() async {
    var url = "/VanBanDuThao/Getnhomdonvi";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => NhomNguoiDungItem.fromMap(f)).toList();
    return lst;
  }

// post trình văn bản
  Future<dynamic> posttrinhky(dataquery) async {
    try {
      var url = "/VanBanDuThao/TrinhKy";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

// duyệt dự thảo
  Future<dynamic> postapproved(dataquery) async {
    try {
      var url = "/VanBanDuThao/Approved";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  // từ chối dự thảo
  Future<dynamic> postreject(dataquery) async {
    try {
      var url = "/VanBanDuThao/Approved";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

// phát hành
  Future<dynamic> postDistribute(dataquery) async {
    try {
      var url = "/VanBanDuThao/Distribute";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

// post trình văn bản
  Future<dynamic> postykien(dataquery) async {
    try {
      var url = "/VanBanDuThao/ykien";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  Future<dynamic> posthoanthanh(dataquery) async {
    try {
      var url = "/VanBanDuThao/hoanthanh";
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }
}
