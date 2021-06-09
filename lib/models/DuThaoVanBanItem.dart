import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';
import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/VanBanDiGuiNhanItem.dart';

import 'FileAttachItem.dart';

class DuThaoVanBanItem {
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
  List<DonViItem> lstdonvi;
  List<VanBanDiGuiNhanItem> lstguinhan;
  String strdonvinhan;
  String strnhomdonvinhan;
  String strnguoinhan;
  String hanxuly;
  String ngaytao;
  String tennguoitao;
  String strTrangThai;
  bool isTrinh;
  bool isDuyet;
  bool isTuChoi;
  bool isPhatHanh;
  bool isKetThuc;
  bool isHuyDuyet;
  bool isTraLai;
  bool isThuHoi;
  int vitringuoikyid;
  bool ishoanthanh;
  List<DanhMucGiaTriItem> lstdanhmucgiatri;
  DuThaoVanBanItem(
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
      this.ngaytao,
      this.tennguoitao,
      this.strTrangThai,
      this.isTrinh,
      this.isDuyet,
      this.isTuChoi,
      this.isPhatHanh,
      this.isKetThuc,
      this.isHuyDuyet,
      this.isTraLai,
      this.isThuHoi,
      this.vitringuoikyid,
      this.lstdanhmucgiatri,
      this.ishoanthanh,
      this.lstguinhan,
      this.total});
  DuThaoVanBanItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ngaytao = map['NgayTao'];
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
    isvanbandi = map['IsVanBanDi'];
    strTrangThai = map['strTrangThai'];
    tennguoitao = map['TenNguoiTao'];
    total = map['TotalRecord'];
    isTrinh = map['IsTrinh'];
    isDuyet = map['IsDuyet'];
    isTuChoi = map['IsTuChoi'];
    isPhatHanh = map['IsPhatHanh'];
    ishoanthanh = map['IsHoanThanh'];
    isKetThuc = map['IsKetThuc'];
    isHuyDuyet = map['IsHuyDuyet'];
    isTraLai = map['IsTraLai'];
    isThuHoi = map['IsThuHoi'];
    vitringuoikyid = map['ViTriNguoiKyID'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = new List<FileAttachItem>();
    if (map['LstDonVi'] != null && map['LstDonVi'].length > 0) {
      List<dynamic> vbData = map['LstDonVi'];
      lstdonvi = vbData.map((f) => DonViItem.fromMap(f)).toList();
    } else
      lstdonvi = new List<DonViItem>();
    if (map['LtsDanhMucGiaTri'] != null && map['LtsDanhMucGiaTri'].length > 0) {
      List<dynamic> vbData = map['LtsDanhMucGiaTri'];
      lstdanhmucgiatri =
          vbData.map((f) => DanhMucGiaTriItem.fromMap(f)).toList();
    } else
      lstdanhmucgiatri = new List<DanhMucGiaTriItem>();

    if (map['LtsVanBanDiGuiNhan'] != null &&
        map['LtsVanBanDiGuiNhan'].length > 0) {
      List<dynamic> vbData = map['LtsVanBanDiGuiNhan'];
      lstguinhan = vbData.map((f) => VanBanDiGuiNhanItem.fromMap(f)).toList();
    } else
      lstguinhan = new List<VanBanDiGuiNhanItem>();
  }
}
