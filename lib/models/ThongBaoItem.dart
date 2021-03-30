import 'FileAttachItem.dart';

class ThongBaoItem {
  int id;
  String ten;
  String thoigianbatdau;
  String thoigianketthuc;
  String mota;
  String tendoivi;
  int total;
  List<FileAttachItem> lstfile;
  ThongBaoItem({
    this.id,
    this.ten,
    this.thoigianbatdau,
    this.thoigianketthuc,
    this.mota,
    this.tendoivi,
    this.lstfile,
    this.total,
  });
  ThongBaoItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    total = map['TotalRecord'];
    thoigianbatdau = map['ThoiGianBatDau'];
    thoigianketthuc = map['ThoiGianKetThuc'];
    mota = map['MoTa'];
    tendoivi = map['TenDonVi'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = <FileAttachItem>[];
  }
}
