import 'package:app_eoffice/models/Nguoidungitem.dart';

import 'Base_service.dart';

// ignore: camel_case_types
class NguoiDung_Api {
  Base_service base_service = new Base_service();

  Future<List<NguoiDungItem>> getnguoidungbychucvu(dataquery) async {
    var url = "/NguoiDung/getnguoiDungbyDonViChucVu";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    return lst;
  }

  Future<List<NguoiDungItem>> getnguoidungbyquyenhan(dataquery) async {
    var url = "/NguoiDung/getnguoiDungbyquyenhan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    return lst;
  }

  Future<List<NguoiDungItem>> getnguoidungbydonvi(dataquery) async {
    var url = "/NguoiDung/GetnguoiDungByPhongBan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    return lst;
  }

  Future<NguoiDungItem> getnguoidungbyid(dataquery) async {
    var url = "/NguoiDung/getnguoidungbyid";
    var vbData = await base_service.getbase(dataquery, url);
    var obj = NguoiDungItem.fromMap(vbData);
    return obj;
  }
}
