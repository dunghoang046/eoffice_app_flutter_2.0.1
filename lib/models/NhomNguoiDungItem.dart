class NhomNguoiDungItem {
  int id;
  String ten;
  NhomNguoiDungItem(this.id, this.ten);
  NhomNguoiDungItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
  }
}
