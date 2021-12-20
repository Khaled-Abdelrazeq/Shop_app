import 'package:dio/dio.dart';
import 'package:shop_app/shared/contsts/constants.dart';

class DioHandler {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {'Content-Type': 'application/json'}));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? auth,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': auth,
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? auth,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': auth,
      'Content-Type': 'application/json'
    };
    return await dio.post(path, data: data);
  }

  static Future<Response> updateData({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    required String auth,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': auth,
      'Content-Type': 'application/json'
    };
    return await dio.put(path, data: data);
  }
}
