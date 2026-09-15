import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class SanitizedDioLogger extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) return super.onRequest(options, handler);

    final data = options.data;
    dynamic sanitizedData = data;

    if (data is Map<String, dynamic>) {
      sanitizedData = _sanitizeMap(data);
    } else if (data is FormData) {
      sanitizedData = "FormData(...)";
    }

    debugPrint("➡️ REQUEST [${options.method}] => PATH: ${options.path}");
    debugPrint("➡️ HEADERS: ${_sanitizeMap(options.headers)}");
    if (sanitizedData != null) {
      debugPrint("➡️ DATA: $sanitizedData");
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kDebugMode) return super.onResponse(response, handler);

    debugPrint("⬅️ RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.path}");
    debugPrint("⬅️ DATA: ${response.data}");

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) return super.onError(err, handler);

    debugPrint("❌ ERROR [${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    debugPrint("❌ MESSAGE: ${err.message}");
    if (err.response?.data != null) {
      debugPrint("❌ RESPONSE DATA: ${err.response?.data}");
    }

    super.onError(err, handler);
  }

  Map<String, dynamic> _sanitizeMap(Map<String, dynamic> map) {
    final sanitized = <String, dynamic>{};
    final sensitiveKeys = ['password', 'token', 'oldPassword', 'newPassword', 'accessToken'];
    
    map.forEach((key, value) {
      if (sensitiveKeys.any((sensitive) => key.toLowerCase().contains(sensitive.toLowerCase()))) {
        sanitized[key] = '********';
      } else if (value is Map<String, dynamic>) {
        sanitized[key] = _sanitizeMap(value);
      } else {
        sanitized[key] = value;
      }
    });
    return sanitized;
  }
}