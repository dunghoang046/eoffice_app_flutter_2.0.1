class LichlamViecItem {
  int id;
  String thoigianbatdau;
  String thoigianketthuc;
  String lanhdaochutri;
  String thanhphanthamdu;
  String congtacchuanbi;
  String diadiem;
  String strnguoidung;
  String chiase;
  String ngaytao;
  String noidung;
  String tenphonghop;
  String trangthaiid;
  LichlamViecItem({
    this.id,
    this.thoigianbatdau,
    this.thoigianketthuc,
    this.lanhdaochutri,
    this.thanhphanthamdu,
    this.congtacchuanbi,
    this.diadiem,
    this.strnguoidung,
    this.chiase,
    this.ngaytao,
    this.noidung,
    this.tenphonghop,
    this.trangthaiid,
  });
  LichlamViecItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    thoigianbatdau = map['ThoiGianBatDau'];
    thoigianketthuc = map['ThoiGianKetThuc'];
    lanhdaochutri = map['LanhDaoChuTri'];
    thanhphanthamdu = map['ThanhPhanThamDu'];
    congtacchuanbi = map['CongTacChuanBi'];
    diadiem = map['DiaDiem'];
    strnguoidung = map['StrNguoiDung'];
    chiase = map['ChiaSe'];
    ngaytao = map['NgayTao'];
    noidung = map['NoiDung'];
    tenphonghop = map['TenPhongHop'];
    // trangthaiid = map['TrangThaiID'];
  }
}
