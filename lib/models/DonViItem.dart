class DonViItem {
  int id;
  String ten;
  int thutu;
  int donvichaid;
  bool isdonvi;
  String diachi;
  String tenviettat;
  String dienthoai;
  int cap;
  DonViItem({
    this.id,
    this.ten,
    this.thutu,
    this.donvichaid,
    this.isdonvi,
    this.diachi,
    this.dienthoai,
    this.tenviettat,
    this.cap,
  });
  DonViItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    thutu = map['ThuTu'];
  }
}
