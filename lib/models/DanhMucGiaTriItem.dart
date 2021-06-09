class DanhMucGiaTriItem {
  int id;
  String viettat;
  String tenDanhMuc;
  int thuTu;
  bool suDung;
  String moTa;
  String ten;
  DanhMucGiaTriItem(
      {this.id,
      this.viettat,
      this.tenDanhMuc,
      this.thuTu,
      this.suDung,
      this.moTa,
      this.ten});
  DanhMucGiaTriItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    tenDanhMuc = map['TenDanhMuc'];
    thuTu = map['ThuTu'];
    ten = map['Ten'];
  }
}
