class WorkTaskCommentItem {
  int createdUserID;
  String createdDate;
  String description;
  int parentID;
  int taskID;
  String tenNguoiTao;
  String urlAnhDaiDien;
  WorkTaskCommentItem(
    this.createdDate,
    this.createdUserID,
    this.description,
    this.parentID,
    this.taskID,
    this.tenNguoiTao,
    this.urlAnhDaiDien,
  );
  WorkTaskCommentItem.fromMap(Map<String, dynamic> map) {
    createdUserID = map['CreatedUserID'];
    createdDate = map['CreatedDate'];
    description = map['Description'];
    parentID = map['ParentID'];
    taskID = map['TaskID'];
    tenNguoiTao = map['TenNguoiTao'];
    urlAnhDaiDien = map['urlAnhDaiDien'];
  }
}
