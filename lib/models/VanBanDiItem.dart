import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';
import 'package:app_eoffice/models/DonViItem.dart';

import 'FileAttachItem.dart';

class VanBanDiItem {
  int id;
  String sokyhieu;
  String thutu;
  int thutusearch;
  String ngayky;
  String ngaybanhanh;
  String trichyeu;
  int trangthaiid;
  int donviid;
  int phongbanid;
  int sovanbanid;
  int nguoitaoid;
  bool isvanbandi;
  int nguoikyid;
  String ghichu;
  String tennguoiky;
  String tendonvisoanthao;
  String tensovanban;
  String tenloaivanban;
  int total;
  List<FileAttachItem> lstfile;
  List<DanhMucGiaTriItem> lstdanhmucgiatri;
  List<DonViItem> lstdonvi;
  String strdonvinhan;
  String strnhomdonvinhan;
  String strnguoinhan;
  String hanxuly;
  VanBanDiItem(
      {this.id,
      this.sokyhieu,
      this.thutu,
      this.thutusearch,
      this.ngayky,
      this.ngaybanhanh,
      this.trichyeu,
      this.trangthaiid,
      this.donviid,
      this.phongbanid,
      this.sovanbanid,
      this.nguoitaoid,
      this.isvanbandi,
      this.nguoikyid,
      this.ghichu,
      this.tennguoiky,
      this.tendonvisoanthao,
      this.tensovanban,
      this.tenloaivanban,
      this.hanxuly,
      this.lstfile,
      this.strdonvinhan,
      this.strnhomdonvinhan,
      this.strnguoinhan,
      this.lstdonvi,
      this.lstdanhmucgiatri,
      this.total});
  VanBanDiItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    sokyhieu = map['SoKyHieu'];
    thutu = map['ThuTu'];
    thutusearch = map['ThuTuSearch'];
    ngayky = map['NgayKy'];
    ngaybanhanh = map['NgayBanHanh'];
    trichyeu = map['TrichYeu'];
    trangthaiid = map['TrangThaiID'];
    donviid = map['DonViID'];
    phongbanid = map['PhongBanID'];
    nguoitaoid = map['NguoiTaoID'];
    sovanbanid = map['SoVanBanID'];
    nguoikyid = map['NguoiKyID'];
    tennguoiky = map['TenNguoiKy'];
    tendonvisoanthao = map['TenDonViSoanThao'];
    tensovanban = map['TenSoVanBan'];
    hanxuly = map['HanXuLy'];
    tenloaivanban = map['TenLoaiVanBan'];
    strdonvinhan = map['strdonvinhan'];
    strnhomdonvinhan = map['strnhomnguoinhan'];
    strnguoinhan = map['strnguoinhan'];
    total = map['TotalRecord'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = <FileAttachItem>[];
    if (map['LstDonVi'] != null && map['LstDonVi'].length > 0) {
      List<dynamic> vbData = map['LstDonVi'];
      lstdonvi = vbData.map((f) => DonViItem.fromMap(f)).toList();
    } else
      lstdonvi = <DonViItem>[];

    if (map['LtsDanhMucGiaTri'] != null && map['LtsDanhMucGiaTri'].length > 0) {
      List<dynamic> vbData = map['LtsDanhMucGiaTri'];
      lstdanhmucgiatri =
          vbData.map((f) => DanhMucGiaTriItem.fromMap(f)).toList();
    } else
      lstdanhmucgiatri = new List<DanhMucGiaTriItem>();
  }
}
