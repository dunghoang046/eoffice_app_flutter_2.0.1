class DanhMucXeItem {
  int id;
  String bienso;
  String ten;
  int thuTu;
  bool suDung;
  DanhMucXeItem({
    this.id,
    this.ten,
    this.bienso,
    this.thuTu,
    this.suDung,
  });
  DanhMucXeItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    thuTu = map['ThuTu'];
    bienso = map['BienSo'];
  }
}
