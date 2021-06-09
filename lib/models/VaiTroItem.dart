class VaiTroItem {
  int id;
  String ten;
  int thutu;
  VaiTroItem({this.id, this.ten, this.thutu});
  VaiTroItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    thutu = map['ThuTu'];
  }
}
