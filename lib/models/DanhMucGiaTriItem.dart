class DanhMucGiaTriItem {
  int id;
  String viettat;
  String tenDanhMuc;
  int thuTu;
  bool suDung;
  String moTa;
  DanhMucGiaTriItem({
    this.id,
    this.viettat,
    this.tenDanhMuc,
    this.thuTu,
    this.suDung,
    this.moTa,
  });
  DanhMucGiaTriItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    tenDanhMuc = map['Ten'];
    thuTu = map['ThuTu'];
  }
}
