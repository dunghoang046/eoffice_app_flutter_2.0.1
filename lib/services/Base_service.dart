import 'package:app_eoffice/models/Nguoidungitem.dart';
import 'package:app_eoffice/utils/Base.dart';
import "package:dio/dio.dart";

String token = '';
NguoiDungItem nguoidungsession = new NguoiDungItem();

// ignore: camel_case_types
class Base_service {
  final baseUrl = 'http://192.168.0.112:8092//api';
  // final _baseUrl = 'http://api.e-office.vn//api';
  // final baseUrl = 'http://apihpu2.e-office.vn//api';
  // final _baseUrl = 'http://192.168.43.4:8086//api';
  static final Base_service _internal = Base_service.internal();
  factory Base_service() => _internal;
  Base_service.internal();
  getHeaders() {
    return {
      'Accept': 'application/json, text/plain, */*',
      'Content-Type': 'application/json',
      'Authorization': "**",
      'User-Aagent': "4.1.0;android;6.0.1;default;A001",
      "HZUID": "2",
    };
  }

// ignore: unused_element
  Future<dynamic> getlogin(data1) async {
    Dio dio = new Dio();
    NguoiDungItem user;
    try {
      // dio.options.headers['content-Type'] = 'text/plain; charset=UTF-8';
      // dio.options.headers['Access-Control-Allow-Origin'] = '*';
      // dio.options.headers['Access-Control-Allow-Methods'] = 'GET , POST';
      dio.options.headers = getHeaders();
      var response = await dio.post('$baseUrl/NguoiDung/Login', data: data1);
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
      var response = await dio.get('$baseUrl/$urlapi',
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
    var response = await dio.post('$baseUrl/$urlapi',
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

  Future<dynamic> postcauhinhnhannotification(dataquery) async {
    try {
      var url = "/NguoiDung/cauhinhnhannotification";
      var message = await post(dataquery, url);
      return message;
    } catch (ex) {
      return ex;
    }
  }

  void dispose() {
    dio.close();
  }
}
