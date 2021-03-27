import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/NguoiDungitem.dart';
import 'package:app_eoffice/models/NhomDonViItem.dart';
import 'package:app_eoffice/models/NhomNguoiDungItem.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';
import 'package:app_eoffice/services/Base_service.dart';

class Vanbandi_api {
  Base_service base_service = new Base_service();
  List<VanBanDiItem> lstvanbandi = <VanBanDiItem>[];
  int currentPageNow = 1;
  int total = 0;
  // lấy tất cả dữ liệu
  Future<List<VanBanDiItem>> getvanban(dataquery, currentPage) async {
    var url = "/vanbandi/GetDanhSachVanBanDi";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstvanbandi = vbData.map((f) => VanBanDiItem.fromMap(f)).toList();
    return lstvanbandi;
  }

  Future<VanBanDiItem> getbyId(dataquery) async {
    var url = "/vanbandi/GetByID";
    var vbData = await base_service.getbase(dataquery, url);
    var obj = VanBanDiItem.fromMap(vbData);
    return obj;
  }

// lấy thông tin gửi nhận
  Future<List<VanBanDiGuiNhanItem>> getvanbandiguinhan(dataquery) async {
    var url = "/vanbandi/Getvanbandiguinhan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lstguinhan = vbData.map((f) => VanBanDiGuiNhanItem.fromMap(f)).toList();
    return lstguinhan;
  }

//lấy nhóm người dùng
  Future<List<NhomNguoiDungItem>> getnhomnguoidung() async {
    var url = "/vanbandi/GetNhomnguoidung";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => NhomNguoiDungItem.fromMap(f)).toList();
    return lst;
  }

// lấy nhóm đơn vị
  Future<List<NhomDonViItem>> getnhomdonvi() async {
    var url = "/vanbandi/GetNhomDonvi";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => NhomDonViItem.fromMap(f)).toList();
    return lst;
  }

// lấy người dùng
  Future<List<NguoiDungItem>> getnguoidung() async {
    var url = "/vanbandi/Getnguoidung";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    return lst;
  }

// lấy đơnvị
  Future<List<DonViItem>> getdonvi() async {
    var url = "/vanbandi/GetDonViNhan";
    List<dynamic> vbData = await base_service.getbase(null, url);
    var lst = vbData.map((f) => DonViItem.fromMap(f)).toList();
    return lst;
  }

// post chuyển văn bản
  Future<dynamic> postchuyenvanban(dataquery) async {
    var url = "/vanbandi/chuyenvanban";
    var message = await base_service.post(dataquery, url);
    return message;
  }
}
