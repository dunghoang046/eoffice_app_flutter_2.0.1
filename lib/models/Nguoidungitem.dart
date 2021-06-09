import 'package:app_eoffice/models/DonViItem.dart';
import 'package:app_eoffice/models/NguoiDungDonViNhomNguoiDungItem.dart';
import 'package:app_eoffice/models/VaiTroItem.dart';

class NguoiDungItem {
  int id;
  String tenhienthi;
  String tentruycap;
  String matkhau;
  int thutu;
  String ngaysinh;
  String gioitinh;
  String email;
  String diachi;
  String dienthoai;
  String didong;
  String anhdaidien;
  int chucvuid;
  int vitriid;
  String tenchucvu;
  String tendonvi;
  int donviid;
  int donvichaid;
  bool islanhdao;
  bool islargest;
  String tenchucvuhienthi;
  String tenviettatdonvi;
  String tenviettatphongban;
  List<dynamic> ltsphongbanid;
  String quyenhan;
  String token;
  String linkanh;
  String tennhomnguoidung;
  List<DonViItem> lstphongban;
  List<DonViItem> lstdonvicuanguoidung;
  List<VaiTroItem> lstvaitro;
  List<NguoiDungDonViNhomNguoiDungItem> lstthongtin;
  NguoiDungItem({
    this.id,
    this.tenhienthi,
    this.thutu,
    this.ngaysinh,
    this.gioitinh,
    this.email,
    this.diachi,
    this.dienthoai,
    this.didong,
    this.anhdaidien,
    this.chucvuid,
    this.vitriid,
    this.tenchucvu,
    this.tendonvi,
    this.donviid,
    this.donvichaid,
    this.islanhdao,
    this.islargest,
    this.tenchucvuhienthi,
    this.tenviettatdonvi,
    this.tenviettatphongban,
    this.ltsphongbanid,
    this.quyenhan,
    this.tentruycap,
    this.matkhau,
    this.token,
    this.linkanh,
    this.tennhomnguoidung,
    this.lstphongban,
    this.lstdonvicuanguoidung,
    this.lstvaitro,
    this.lstthongtin,
  });
  NguoiDungItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    tenhienthi = map['TenHienThi'];
    thutu = map['ThuTu'];
    // ngaysinh = map['NgaySinh'];
    token = map['Token'];
    tentruycap = map['TenTruyCap'];
    donviid = map['DonViID'];
    donvichaid = map['DonViChaID'];
    quyenhan = map['QuyenHan'];
    tendonvi = map['TenDonVi'];
    ltsphongbanid = map['LtsPhongBanID'];
    islanhdao = map['IsLanhDao'];
    vitriid = map['ViTriID'];
    email = map['Email'];
    tenchucvu = map['TenChucVu'];
    linkanh = map['LinkAnh'];
    dienthoai = map['DienThoai'];
    tennhomnguoidung = map['TenNhomNguoiDung'];
    didong = map['DiDong'];
    anhdaidien = map['AnhDaiDien'];
    if (map['LstPhongBan'] != null && map['LstPhongBan'].length > 0) {
      List<dynamic> vbData = map['LstPhongBan'];
      lstphongban = vbData.map((f) => DonViItem.fromMap(f)).toList();
    } else
      lstphongban = <DonViItem>[];
    if (map['LtsDonViCuaNguoiDung'] != null &&
        map['LtsDonViCuaNguoiDung'].length > 0) {
      List<dynamic> vbData = map['LtsDonViCuaNguoiDung'];
      lstdonvicuanguoidung = vbData.map((f) => DonViItem.fromMap(f)).toList();
    } else
      lstphongban = <DonViItem>[];
    if (map['LtsVaiTro'] != null && map['LtsVaiTro'].length > 0) {
      List<dynamic> vbData = map['LtsVaiTro'];
      lstvaitro = vbData.map((f) => VaiTroItem.fromMap(f)).toList();
    } else
      lstvaitro = <VaiTroItem>[];
    if (map['LtsThongTin'] != null && map['LtsThongTin'].length > 0) {
      List<dynamic> vbData = map['LtsThongTin'];
      lstthongtin = vbData
          .map((f) => NguoiDungDonViNhomNguoiDungItem.fromMap(f))
          .toList();
    } else
      lstthongtin = <NguoiDungDonViNhomNguoiDungItem>[];
  }
}
