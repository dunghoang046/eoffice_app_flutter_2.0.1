class FileAttachItem {
  int id;
  String ten;
  String filelink;
  bool isFileScan;
  FileAttachItem(this.id, this.filelink, this.ten, this.isFileScan);
  FileAttachItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    ten = map['Ten'];
    filelink = map['FileLink'];
    isFileScan = map['IsFileScan'];
  }



  Map<String, dynamic> toJson() => {
    'ID': id,
    'Ten':ten,
    'FileLink':filelink,
    'IsFileScan':isFileScan
  };
}
