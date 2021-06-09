class VanBanDiGuiNhanItem {
  int id;
  int nguoiguiid;
  int nguoinhanid;
  int donviid;
  int vanbanid;
  String tennguoigui;
  String tennguoinhan;
  String thoigiangui;
  String thoigiannhan;
  int trangthai;
  String tendonvinhan;
  bool daumoi;
  bool phoihop;
  VanBanDiGuiNhanItem(
      this.id,
      this.nguoiguiid,
      this.nguoinhanid,
      this.donviid,
      this.vanbanid,
      this.tennguoigui,
      this.tennguoinhan,
      this.thoigiangui,
      this.thoigiannhan,
      this.trangthai,
      this.tendonvinhan,
      this.daumoi,
      this.phoihop);
  VanBanDiGuiNhanItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    nguoiguiid = map['NguoiGuiID'];
    nguoinhanid = map['NguoiNhanID'];
    vanbanid = map['VanBanDenID'];
    donviid = map['DonViID'];
    tennguoigui = map['TenNguoiGui'];
    tennguoinhan = map['TenNguoiNhan'];
    tendonvinhan = map['TenDonViNhan'];
    daumoi = map['DauMoi'];
    phoihop = map['PhoiHop'];
    thoigiangui = map['ThoiGianGui'];
    thoigiannhan = map['ThoiGianDoc'];
    trangthai = map['TrangThaiID'];
  }
}
