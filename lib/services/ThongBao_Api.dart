import 'package:app_eoffice/models/ThongBaoItem.dart';
import 'Base_service.dart';

// ignore: camel_case_types
class ThongBao_Api {
  // ignore: non_constant_identifier_names
  Base_service base_service = new Base_service();
  List<ThongBaoItem> lstnoti = <ThongBaoItem>[];
  Future<List<ThongBaoItem>> getallthongbao(dataquery, currentPage) async {
    try {
      var url = "/ThongBao/Getallthongbao";
      List<dynamic> vbData = await base_service.getbase(dataquery, url);
      lstnoti = vbData.map((f) => ThongBaoItem.fromMap(f)).toList();
      return lstnoti;
    } catch (ex) {
      return <ThongBaoItem>[];
    }
  }
}
