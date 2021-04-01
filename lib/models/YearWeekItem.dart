class YearWeekItem {
  int year;
  int week;
  YearWeekItem({this.year, this.week});
  YearWeekItem.fromMap(Map<String, dynamic> map) {
    year = map['Year'];
    week = map['Week'];
  }
}
