import 'package:app_eoffice/models/DonViItem.dart';
import 'Base_service.dart';

class DonVi_Api {
  Base_service base_service = new Base_service();

  Future<List<DonViItem>> getdonvi(dataquery) async {
    var url = "/DonVi/getdonvi";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    var lst = vbData.map((f) => DonViItem.fromMap(f)).toList();
    return lst;
  }
}
