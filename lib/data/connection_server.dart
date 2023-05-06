import 'package:dio/dio.dart';

import 'package:flutter_job/data/api_urls.dart';

class ConnectionServer {
  final dio = Dio(BaseOptions(
    baseUrl: urlServerBackend,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    sendTimeout: 10000,
  ));

  Future<Response<dynamic>> get(String url) => dio.get<dynamic>(url);

  Future<Response> post(String url, String json) =>
      dio.post<Future<Response>>(url, data: json);

  Future<Response> delete(String url) => dio.delete<Future<Response>>(url);
}
