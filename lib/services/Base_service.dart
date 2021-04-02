import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/utils/Base.dart';
import "package:dio/dio.dart";

String token = '';
NguoiDungItem nguoidungsession = new NguoiDungItem();

// ignore: camel_case_types
class Base_service {
  //final _baseUrl = 'http://192.168.202.21:8086//api';
  final _baseUrl = 'http://api.e-office.vn//api';
  // final _baseUrl = 'http://192.168.43.4:8086//api';
  // final _baseUrl = ' https://jsonplaceholder.typicode.com/todos/1';
  static final Base_service _internal = Base_service.internal();
  factory Base_service() => _internal;
  Base_service.internal();

// ignore: unused_element
  Future<dynamic> getlogin(data1) async {
    Dio dio = new Dio();
    NguoiDungItem user;
    try {
      var response = await dio.post('$_baseUrl/NguoiDung/Login', data: data1);
      if (response.statusCode == 200) {
        if (response.data != null &&
            response.data['Data'] != null &&
            response.data["StatusCode"] == 0) {
          var objdata = response.data['Data'];
          user = NguoiDungItem.fromMap(objdata);
        } else {
          basemessage = 'Thông tin đăng nhập không đúng';
        }
      } else {
        ischeckurl = false;
        basemessage = 'Thông tin đăng nhập không đúng';
      }
    } catch (ex) {
      ischeckurl = false;
      basemessage = 'Đã có lỗi xảy ra vui lòng đăng nhập lại: ' + ex.toString();
    }
    return user;
  }

  Dio dio = new Dio();
  Future getbase<T>(data, urlapi) async {
    if (token.length <= 0) {
      return null;
    }
    var objdata;
    try {
      var response = await dio.get('$_baseUrl/$urlapi',
          queryParameters: data,
          options: Options(headers: {
            'Authorization': '$token',
          }, contentType: 'application/json; charset=utf-8'));
      if (response.statusCode == 200) {
        if (response.data['Data'] != null && response.data["StatusCode"] == 0) {
          objdata = response.data['Data'];
          return objdata;
        }
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      throw Exception('Failed to get data');
    }
  }

  dynamic post(data, urlapi) async {
    Dio dio = new Dio();
    var response = await dio.post('$_baseUrl/$urlapi',
        data: data,
        options: Options(headers: {
          'Authorization': '$token',
        }, contentType: 'application/json; charset=utf-8'));
    if (response.statusCode == 200) {
      if (response.data != null &&
          response.data['Data'] != null &&
          response.data["StatusCode"] == 0) {
        var objdata = response.data['Data'];
        return objdata;
      }
    }
    return null;
  }

  void dispose() {
    dio.close();
  }
}
