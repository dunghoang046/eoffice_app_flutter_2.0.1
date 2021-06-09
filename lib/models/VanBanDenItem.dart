import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';

import 'FileAttachItem.dart';
import 'VanBanDenGuiNhanItem.dart';
import 'VanbandentrangthaiItem.dart';

class VanBanDenItem {
  int id;
  int thutu;
  String tensovanban;
  String sokyhieu;
  String ngaybanhanh;
  String ngayden;
  String hanxuly;
  int coquanbanhanhid;
  int loaivanbanid;
  String sobill;
  int donviid;
  int nam;
  int thang;
  String trichyeu;
  int nguoitaoid;
  String ngaytao;
  bool isxuly;
  String tenloaivanban;
  String tencoquanbanhanh;
  String ghichu;
  int total;
  int trangthaivanbanid;
  List<FileAttachItem> lstfile;
  List<VanBanDenGuiNhanItem> lstguinhan;
  List<DanhMucGiaTriItem> lstdanhmucgiatri;
  List<VanbandentrangthaiItem> lsttrangthai;
  int vanbandenid;
  int vanbandiid;
  VanBanDenItem(
      {this.id,
      this.thutu,
      this.tensovanban,
      this.sokyhieu,
      this.ngaybanhanh,
      this.ngayden,
      this.hanxuly,
      this.coquanbanhanhid,
      this.loaivanbanid,
      this.sobill,
      this.donviid,
      this.nam,
      this.thang,
      this.trichyeu,
      this.nguoitaoid,
      this.ngaytao,
      this.isxuly,
      this.tenloaivanban,
      this.tencoquanbanhanh,
      this.total,
      this.trangthaivanbanid,
      this.lstfile,
      this.vanbandenid,
      this.vanbandiid,
      this.lstguinhan,
      this.lsttrangthai,
      this.lstdanhmucgiatri,
      this.ghichu});
  VanBanDenItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    sokyhieu = map['SoKyHieu'];
    trichyeu = map['TrichYeu'];
    total = map['TotalRecord'];
    ngayden = map['NgayDen'];
    tencoquanbanhanh = map['CoQuanBanHanhText'];
    tensovanban = map['TenSoVanBan'];
    tenloaivanban = map['TenLoaiVanBan'];
    trangthaivanbanid = map['TrangThaiVBID'];
    isxuly = map['IsXuLy'];
    vanbandenid = map['VanBanDenID'];
    vanbandiid = map['VanBanDiID'];
    ngaybanhanh = map['NgayBanHanh'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = new List<FileAttachItem>();

    if (map['LtsVanBanDenGuiNhan'] != null &&
        map['LtsVanBanDenGuiNhan'].length > 0) {
      List<dynamic> vbData = map['LtsVanBanDenGuiNhan'];
      lstguinhan = vbData.map((f) => VanBanDenGuiNhanItem.fromMap(f)).toList();
    } else
      lstguinhan = new List<VanBanDenGuiNhanItem>();
    if (map['LtsVBDTrangThai'] != null && map['LtsVBDTrangThai'].length > 0) {
      List<dynamic> vbData = map['LtsVBDTrangThai'];
      lsttrangthai =
          vbData.map((f) => VanbandentrangthaiItem.fromMap(f)).toList();
    } else
      lsttrangthai = new List<VanbandentrangthaiItem>();

    if (map['LtsDanhMucGiaTri'] != null && map['LtsDanhMucGiaTri'].length > 0) {
      List<dynamic> vbData = map['LtsDanhMucGiaTri'];
      lstdanhmucgiatri =
          vbData.map((f) => DanhMucGiaTriItem.fromMap(f)).toList();
    } else
      lstdanhmucgiatri = new List<DanhMucGiaTriItem>();
  }
}
