import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:dio/dio.dart';

class Exceptions implements Exception {
  final ErrorModel errorModel;

  Exceptions({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 401: //unauthorized
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 403: //forbidden
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 404: //not found
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 409: //cofficient
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 422: //  Unprocessable Entity
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
        case 504: // Server exception
          throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
      }
    case DioExceptionType.transformTimeout:
      throw Exceptions(errorModel: ErrorModel.fromJson(e.response!.data));
  }
}
