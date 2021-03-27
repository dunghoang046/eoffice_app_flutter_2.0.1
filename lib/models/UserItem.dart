class UserItem {
  int id;
  String username;
  String fullName;
  UserItem(
    this.id,
    this.username,
    this.fullName,
  );
  UserItem.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    username = map['Username'];
    fullName = map['FullName'];
  }
}
