import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/core/API/api_interceptors.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/core/services/sanitized_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioConsumer implements ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
      followRedirects: false,
      headers: {"Accept": "application/json"},
    );
    dio.interceptors.add(ApiInterceptors());
    if (kDebugMode) {
      dio.interceptors.add(SanitizedDioLogger());
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
    bool isFormated = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isFormated && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
    bool isFormated = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormated && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
    bool isFormated = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormated && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }


  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
    bool isFormated = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormated && data is Map<String, dynamic>
            ? FormData.fromMap(data)
            : data,
        queryParameters: queryParam,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    } catch (e) {
      rethrow;
    }
  }


}