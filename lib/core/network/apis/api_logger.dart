import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('REQUEST HEADERS: ${options.headers}');
    debugPrint('REQUEST DATA: ${options.data}');
    debugPrint('REQUEST QUERY PARAMETERS: ${options.queryParameters}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    debugPrint('RESPONSE DATA: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    debugPrint('ERROR MESSAGE: ${err.message}');
    debugPrint('ERROR DATA: ${err.response?.data}');
    super.onError(err, handler);
  }
}
