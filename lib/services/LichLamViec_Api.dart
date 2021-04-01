import 'package:app_eoffice/models/NoiDungLichItem.dart';
import 'package:app_eoffice/models/WeekItem.dart';
import 'package:app_eoffice/models/YearWeekItem.dart';
import 'Base_service.dart';

// ignore: camel_case_types
class LichlamViec_Api {
  // ignore: non_constant_identifier_names
  Base_service base_service = new Base_service();
  List<NoiDungLichItem> lstnoti = <NoiDungLichItem>[];
  Future<List<NoiDungLichItem>> getlichlamviecbytuan(
      dataquery, currentPage) async {
    var url = "/LichlamViec/GetallLichbytuan";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstnoti = vbData.map((f) => NoiDungLichItem.fromMap(f)).toList();
    return lstnoti;
  }

  Future<List<WeekItem>> gettuan(dataquery) async {
    List<WeekItem> lstweek = <WeekItem>[];
    var url = "/LichlamViec/GetWeeksOfYear";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstweek = vbData.map((f) => WeekItem.fromMap(f)).toList();
    return lstweek;
  }

  Future<List<YearWeekItem>> Getyearweek(dataquery) async {
    List<YearWeekItem> lstweek = <YearWeekItem>[];
    var url = "/LichlamViec/Getyearweek";
    List<dynamic> vbData = await base_service.getbase(dataquery, url);
    lstweek = vbData.map((f) => YearWeekItem.fromMap(f)).toList();
    return lstweek;
  }
}
