import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  late Dio dio;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: const String.fromEnvironment("BASE_URL"),
      connectTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log("Request: ${options.method} ${options.path}");
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log("Response: ${response.statusCode} ${response.data}");
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        log("Error: ${e.message}", stackTrace: e.stackTrace, error: e);
        return handler.next(e);
      },
    ));
  }

  factory ApiClient() => _instance;
}
