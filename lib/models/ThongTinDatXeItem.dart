import 'FileAttachItem.dart';

class ThongTinDatXeItem {
  int id;
  String thoigianbatdau;
  String thoigianketthuc;
  String mota;
  String tennguoitao;
  int trangthaiid;
  int donviid;
  String tenphongban;
  String tennguoilaixe;
  int danhmucxeid;
  int nguoitaoid;
  String tendanhmucxe;
  List<FileAttachItem> lstfile;
  int totalRecord;
  String songuoi;
  String diemden;
  String diemdon;
  String tennguoiquantri;
  String lydo;
  String bienso;
  ThongTinDatXeItem(
      {this.id,
      this.thoigianbatdau,
      this.thoigianketthuc,
      this.mota,
      this.tennguoitao,
      this.trangthaiid,
      this.donviid,
      this.tenphongban,
      this.tennguoilaixe,
      this.danhmucxeid,
      this.tendanhmucxe,
      this.lstfile,
      this.totalRecord,
      this.songuoi,
      this.diemden,
      this.diemdon,
      this.tennguoiquantri,
      this.bienso,
      this.nguoitaoid,
      this.lydo});
  ThongTinDatXeItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    totalRecord = map['TotalRecord'];
    thoigianbatdau = map['ThoiGianBatDau'];
    thoigianketthuc = map['ThoiGianKetThuc'];
    mota = map['MoTa'];
    trangthaiid = map['TrangThaiID'];
    tennguoitao = map['TenNguoiTao'];
    tenphongban = map['TenPhongBan'];
    songuoi = map['SoKM'];
    tennguoilaixe = map['TenNguoiLaiXe'];
    tennguoiquantri = map['TenNguoiQuanTri'];
    tendanhmucxe = map['TenDanhMucXe'];
    diemden = map['DiemDen'];
    diemdon = map['DiemDi'];
    bienso = map['BienSo'];
    lydo = map['LyDo'];
    nguoitaoid = map['NguoiTaoID'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = <FileAttachItem>[];
  }
}
