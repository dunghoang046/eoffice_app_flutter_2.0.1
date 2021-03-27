import 'package:app_eoffice/models/NotificationItem.dart';
import 'Base_service.dart';

// ignore: camel_case_types
class Notification_Api {
  // ignore: non_constant_identifier_names
  Base_service base_service = new Base_service();
  List<NotificationItem> lstnoti = <NotificationItem>[];
  Future<List<NotificationItem>> getallnotification(
      dataquery, currentPage) async {
    var url = "/Notification/Getallnotification";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstnoti = vbData.map((f) => NotificationItem.fromMap(f)).toList();
    return lstnoti;
  }
}
