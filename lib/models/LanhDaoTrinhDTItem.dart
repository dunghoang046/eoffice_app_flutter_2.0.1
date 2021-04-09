import 'package:app_eoffice/models/NguoiDungitem.dart';

class LanhDaoTrinhDTItem {
  List<NguoiDungItem> lstlanhdao;
  List<NguoiDungItem> lstlanhdaokhac;
  LanhDaoTrinhDTItem(
    this.lstlanhdao,
    this.lstlanhdaokhac,
  );
  LanhDaoTrinhDTItem.fromMap(Map<String, dynamic> map) {
    if (map['LstLanhDao'] != null && map['LstLanhDao'].length > 0) {
      List<dynamic> vbData = map['LstLanhDao'];
      lstlanhdao = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    } else
      lstlanhdao = <NguoiDungItem>[];
    if (map['LstLanhdaokhac'] != null && map['LstLanhdaokhac'].length > 0) {
      List<dynamic> vbData = map['LstLanhdaokhac'];
      lstlanhdaokhac = vbData.map((f) => NguoiDungItem.fromMap(f)).toList();
    } else
      lstlanhdaokhac = <NguoiDungItem>[];
  }
}
