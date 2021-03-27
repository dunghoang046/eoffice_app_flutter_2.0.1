class Message {
  int id;
  String title;
  bool error;
  Message(
    this.id,
    this.title,
    this.error,
  );
  Message.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    title = map['Title'];
    error = map['Error'];
  }
}
