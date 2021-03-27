class NotificationItem {
  int id;
  int nguoiguiid;
  int nguoinhanid;

  String tennguoigui;
  String tennguoinhan;
  String noidung;
  String ngaytao;
  String link;
  int total;
  int kieuid;
  int itemid;
  NotificationItem(
    this.id,
    this.tennguoigui,
    this.tennguoinhan,
    this.noidung,
    this.ngaytao,
    this.link,
    this.kieuid,
    this.itemid,
  );
  NotificationItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    total = map['totalRecord'];
    tennguoigui = map['TenNguoiGui'];
    // tennguoinhan = map['TenNguoiNhan'];
    noidung = map['NoiDung'];
    ngaytao = map['NgayTao'];
    kieuid = map['KieuID'];
    itemid = map['ItemID'];

    // link = map['Link'];
  }
}
