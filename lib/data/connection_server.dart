import 'package:dio/dio.dart';

import 'package:flutter_job/data/api_urls.dart';

import 'package:flutter_job/data/network_exception.dart';

class ConnectionServer {
  final dio = Dio(BaseOptions(
    baseUrl: urlServerBackend,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
  ));

  Future<Response<dynamic>> get(String url) async {
    try {
      return await dio.get<dynamic>(url);
    } on Exception catch (e) {
      throw NetworkException(e, '$urlServerBackend$url');
    }
  }

  Future<Response> post(String url, String json) async {
    try {
      return await dio.post<Future<Response>>(url, data: json);
    } on Exception catch (e) {
      throw NetworkException(e, '$urlServerBackend$url');
    }
  }

  Future<Response> delete(String url) async {
    try {
      return await dio.delete<Future<Response>>(url);
    } on Exception catch (e) {
      throw NetworkException(e, '$urlServerBackend$url');
    }
  }
}
