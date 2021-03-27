import 'package:app_eoffice/models/Message.dart';
import 'package:app_eoffice/models/VanBanDenGuiNhanItem.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/models/VanBanDenYkienItem.dart';
import 'package:app_eoffice/services/Base_service.dart';

// ignore: camel_case_types
class Vanbanden_api {
  Base_service base_service = new Base_service();
  List<VanBanDenItem> lstvanbanden = <VanBanDenItem>[];
  int currentPageNow = 1;
  int total = 0;
  int xx = 0;
  // lấy tất cả dữ liệu văn bản vs văn thư
  Future<List<VanBanDenItem>> getvanbanden(dataquery, currentPage) async {
    var url = "/vanbanden/GetAllVanBan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDenItem.fromMap(f)).toList();
    return lst;
  }

// lấy văn bản đối vs người dùng
  Future<List<VanBanDenItem>> getvanban(dataquery, currentPage) async {
    var url = "/vanbanden/GetAllVanBan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDenItem.fromMap(f)).toList();
    return lst;
  }

// lấy chi tiết văn bản
  Future<VanBanDenItem> getbyId(dataquery) async {
    var url = "/vanbanden/GetByID";
    var vbData = await base_service.getbase(dataquery, url);
    var obj = VanBanDenItem.fromMap(vbData);
    return obj;
  }

// lấy ý kiến
  Future<List<VanBanDenYKienItem>> getykienvanbanden(dataquery) async {
    var url = "/vanbanden/GetYKienByVanBanID";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDenYKienItem.fromMap(f)).toList();
    return lst;
  }

//lấy văn bản đến bởi người dùng
  Future<List<VanBanDenItem>> getvanbandennguoidung(
      dataquery, currentPage) async {
    var url = "/vanbanden/GetAllVanBanNguoiDung";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDenItem.fromMap(f)).toList();
    return lst;
  }

  // post ý kiến
  Future<dynamic> postykien(dataquery) async {
    var url = "/vanbanden/YKien";
    var message = await base_service.post(dataquery, url);
    return message;
  }

  // post hoàn thành
  Future<dynamic> posthoanthanh(dataquery) async {
    var url = "/vanbanden/hoanthanh";
    var message = await base_service.post(dataquery, url);
    return message;
  }

  // post hoàn thành
  Future<dynamic> postketthuc(dataquery) async {
    var url = "/vanbanden/ketthuc";
    try {
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (error) {}
  }

  Future<dynamic> posttralai(dataquery) async {
    var url = "/vanbanden/tralai";
    try {
      var message = await base_service.post(dataquery, url);
      return message;
    } catch (error) {}
  }

  // check trả lại
  // ignore: missing_return
  Future<Message> checktralai(dataquery) async {
    var url = "/vanbanden/gettralaivanban";
    try {
      var vbData = await base_service.getbase(dataquery, url);
      var obj = Message.fromMap(vbData);
      return obj;
    } catch (error) {}
  }

// lấy văn bản đến gửi nhận
  Future<List<VanBanDenGuiNhanItem>> getvanbandenguinhan(dataquery) async {
    var url = "/vanbanden/Getthongtinguinhan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => VanBanDenGuiNhanItem.fromMap(f)).toList();
    return lst;
  }
}
