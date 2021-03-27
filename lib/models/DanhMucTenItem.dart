import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';

class DanhMucTenItem {
  int id;
  String ten;
  List<DanhMucGiaTriItem> lstdanhmucgt;
  DanhMucTenItem({
    this.id,
    this.ten,
    this.lstdanhmucgt,
  });
  DanhMucTenItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    if (map['LtsDanhMucGiaTri'] != null && map['LtsDanhMucGiaTri'].length > 0) {
      List<dynamic> vbData = map['LtsDanhMucGiaTri'];
      lstdanhmucgt = vbData.map((f) => DanhMucGiaTriItem.fromMap(f)).toList();
    } else
      lstdanhmucgt = new List<DanhMucGiaTriItem>();
  }
}
