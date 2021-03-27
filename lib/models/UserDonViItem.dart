class UserDonViItem {
  int id;
  String username;
  String fullName;
  int donviid;
  String tendonvi;
  UserDonViItem(
    this.id,
    this.username,
    this.fullName,
    this.donviid,
    this.tendonvi,
  );
  UserDonViItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    username = map['Username'];
    fullName = map['FullName'];
    donviid = map['DonViID'];
    tendonvi = map['TenDonVi'];
  }
}
