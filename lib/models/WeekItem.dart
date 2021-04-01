class WeekItem {
  int id;
  String rance;
  WeekItem({this.id, this.rance});
  WeekItem.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    rance = map['Range'];
  }
}
