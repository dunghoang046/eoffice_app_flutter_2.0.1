class VanBanDenYKienItem {
  int id;
  String noidung;
  String ngaytao;
  String tennguoidung;
  int donviid;
  int vitriid;
  int vanbandenid;
  String chucvunguoidung;
  bool isdaumoi;
  int nguoidungid;
  String hanxuly;
  String tendonvi;
  String strDonViDauMoi;
  String strDonViPhoiHop;
  String strNguoiDaumoi;
  String strNguoiPhoiHop;
  String tennguoitao;
  VanBanDenYKienItem(
      this.id,
      this.noidung,
      this.ngaytao,
      this.tennguoidung,
      this.tennguoitao,
      this.donviid,
      this.vitriid,
      this.vanbandenid,
      this.chucvunguoidung,
      this.isdaumoi,
      this.nguoidungid,
      this.hanxuly,
      this.strDonViDauMoi,
      this.strDonViPhoiHop,
      this.strNguoiDaumoi,
      this.tendonvi,
      this.strNguoiPhoiHop);
  VanBanDenYKienItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    noidung = map['NoiDung'];
    ngaytao = map['NgayTao'];
    tennguoidung = map['TenNguoiDung'];
    donviid = map['DonViID'];
    vitriid = map['ViTriID'];
    vanbandenid = map['VanBanDenID'];
    chucvunguoidung = map['ChucVuNguoiDung'];
    isdaumoi = map['DauMoi'];
    nguoidungid = map['NguoiTaoID'];
    hanxuly = map['HanXuLy'];
    tendonvi = map['TenDonVi'];
    strDonViDauMoi = map['strDonViDauMoi'];
    strDonViPhoiHop = map['strDonViPhoiHop'];
    strNguoiDaumoi = map['strNguoiDaumoi'];
    strNguoiPhoiHop = map['strNguoiPhoiHop'];
    tennguoitao = map['TenNguoiTao'];
  }
}
