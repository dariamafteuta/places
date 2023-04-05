import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

final dio = Dio();

BaseOptions baseOptions = BaseOptions(
  baseUrl: 'https://jsonplaceholder.typicode.com',
  connectTimeout: 5000,
  receiveTimeout: 5000,
  sendTimeout: 5000,
);

Future<dynamic> getPost() async {
  initInterceptors();

  final postResponse =  await dio.get<String>('https://jsonplaceholder.typicode.com/users');
  if (postResponse.statusCode == 200) {
    return postResponse.data;
  }
  throw Exception('HTTP request Error. Error code ${postResponse.data}');
}

void initInterceptors() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (e, handler) {
        debugPrint('Ошибка');
      },
      onRequest: (options, handler) {
        debugPrint('Запрос отправляется');

        return handler.next(options);
      },
      onResponse: (e, handler) {
        debugPrint('Ответ получен');

        return handler.next(e);
      },
    ),
  );
}