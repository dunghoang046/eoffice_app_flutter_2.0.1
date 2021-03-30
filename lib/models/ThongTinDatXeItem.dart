import 'FileAttachItem.dart';

class ThongTinDatXeItem {
  int id;
  String thoigianbatdau;
  String thoigianketthuc;
  String mota;
  String tennguoitao;
  String trangthaiid;
  int donviid;
  String tenphongban;
  String tennguoilaixe;
  int danhmucxeid;
  String tendanhmucxe;
  List<FileAttachItem> lstfile;
  ThongTinDatXeItem({
    this.id,
    this.thoigianbatdau,
    this.thoigianketthuc,
    this.mota,
    this.tennguoitao,
    this.trangthaiid,
    this.donviid,
    this.tenphongban,
    this.tennguoilaixe,
    this.danhmucxeid,
    this.tendanhmucxe,
    this.lstfile,
  });
}
