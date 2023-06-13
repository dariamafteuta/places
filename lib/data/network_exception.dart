class NetworkException implements Exception {
  final dynamic message;
  final String url;

  NetworkException(this.message, this.url);

  @override
  String toString() =>
      "В запросе '$url' возникла ошибка: ${message.runtimeType}";
}
