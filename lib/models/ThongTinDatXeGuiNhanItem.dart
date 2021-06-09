class ThongTinDatXeGuiNhanItem {
  int id;
  int nguoiguiid;
  int nguoinhanid;
  String thoigiangui;
  String thoigiannhan;
  int trangthaiid;
  int datxeid;
  String tennguoigui;
  String tennguoinhan;
  ThongTinDatXeGuiNhanItem({
    this.id,
    this.nguoiguiid,
    this.nguoinhanid,
    this.thoigiangui,
    this.thoigiannhan,
    this.trangthaiid,
    this.datxeid,
    this.tennguoigui,
    this.tennguoinhan,
  });
  ThongTinDatXeGuiNhanItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    nguoiguiid = map['NguoiGuiID'];
    nguoinhanid = map['NguoiNhanID'];
    thoigiangui = map['ThoiGianGui'];
    thoigiannhan = map['ThoiGianNhan'];
    trangthaiid = map['TrangThaiID'];
    datxeid = map['DatXeID'];
    tennguoigui = map['TenNguoiGui'];
    tennguoinhan = map['TenNguoiNhan'];
  }
}
