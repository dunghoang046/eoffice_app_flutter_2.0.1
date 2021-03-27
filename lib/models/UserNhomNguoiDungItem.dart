class UserNhomNguoiDungItem {
  int id;
  String username;
  String fullName;
  int nhomid;
  String tennhom;
  UserNhomNguoiDungItem(
    this.id,
    this.username,
    this.fullName,
    this.nhomid,
    this.tennhom,
  );
  UserNhomNguoiDungItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    username = map['Username'];
    fullName = map['FullName'];
    nhomid = map['NhomID'];
    tennhom = map['TenNhom'];
  }
}
