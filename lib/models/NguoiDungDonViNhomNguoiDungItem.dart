class NguoiDungDonViNhomNguoiDungItem {
  int id;
  String ten;
  int thutu;
  String tendonvi;
  bool isdaidien;
  String tennhomnguoidung;
  NguoiDungDonViNhomNguoiDungItem(
      {this.id,
      this.ten,
      this.thutu,
      this.tendonvi,
      this.isdaidien,
      this.tennhomnguoidung});

  NguoiDungDonViNhomNguoiDungItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    thutu = map['ThuTu'];
    tendonvi = map['TenDonVi'];
    isdaidien = map['IsDaiDien'];
    tennhomnguoidung = map['TenNhomNguoiDung'];
  }
}
