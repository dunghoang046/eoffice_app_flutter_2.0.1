class NhomDonViItem {
  int id;
  String ten;
  NhomDonViItem(this.ten, this.id);
  NhomDonViItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
  }
}
