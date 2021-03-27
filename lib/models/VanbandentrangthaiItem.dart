class VanbandentrangthaiItem {
  int vanbandenid;
  int trangthaiid;
  int nguoidungid;
  int donviid;
  String noidung;
  VanbandentrangthaiItem(
    this.vanbandenid,
    this.trangthaiid,
    this.nguoidungid,
    this.donviid,
    this.noidung,
  );
  VanbandentrangthaiItem.fromMap(Map<String, dynamic> map) {
    vanbandenid = map['VanBanDenID'];
    trangthaiid = map['TrangThaiID'];
    nguoidungid = map['NguoiDungID'];
    donviid = map['DonViID'];
    noidung = map['NoiDung'];
  }
}
