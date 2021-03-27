import 'FileAttachItem.dart';

class VanBanDiYKienItem {
  int nguoidungid;
  int donviid;
  String ngaytao;
  String noidung;
  int vanbandiid;
  String tennguoidung;
  int trangthaiid;
  String tendonvi;
  String tennguoiky;
  int nguoikyid;
  String nguoinhanvanban;
  String canbolienquan;
  String phongbandonvilienquan;
  bool isduthao;
  String hanxuly;
  List<FileAttachItem> lstfile;
  VanBanDiYKienItem(
    this.nguoidungid,
    this.donviid,
    this.noidung,
    this.ngaytao,
    this.vanbandiid,
    this.tennguoidung,
    this.trangthaiid,
    this.tendonvi,
    this.tennguoiky,
    this.nguoikyid,
    this.nguoinhanvanban,
    this.canbolienquan,
    this.phongbandonvilienquan,
    this.isduthao,
    this.hanxuly,
    this.lstfile,
  );
  VanBanDiYKienItem.fromMap(Map<String, dynamic> map) {
    nguoidungid = map['NguoiDungID'];
    donviid = map['DonViID'];
    ngaytao = map['NgayTao'];
    noidung = map['NoiDung'];
    vanbandiid = map['VanBanDiID'];
    tennguoidung = map['TenNguoiDung'];
    trangthaiid = map['TrangThaiID'];
    tendonvi = map['TenDonVi'];
    tennguoiky = map['TenNguoiKy'];
    nguoikyid = map['NguoiKyID'];
    nguoinhanvanban = map['NguoiNhanVanBan'];
    canbolienquan = map['CanBoLienQuan'];
    phongbandonvilienquan = map['PhongBanDonViLienQuan'];
    isduthao = map['IsDuThao'];
    hanxuly = map['HanXuLy'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = new List<FileAttachItem>();
  }
}
