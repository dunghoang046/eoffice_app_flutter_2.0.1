import 'package:app_eoffice/models/LichLamViecItem.dart';

class NoiDungLichItem {
  String thu;
  List<LichlamViecItem> listlich;
  NoiDungLichItem({this.thu, this.listlich});
  NoiDungLichItem.fromMap(Map<String, dynamic> map) {
    thu = map['Thu'];
    if (map['LstNoiDung'] != null && map['LstNoiDung'].length > 0) {
      List<dynamic> vbData = map['LstNoiDung'];
      listlich = vbData.map((f) => LichlamViecItem.fromMap(f)).toList();
    } else
      listlich = <LichlamViecItem>[];
  }
}
