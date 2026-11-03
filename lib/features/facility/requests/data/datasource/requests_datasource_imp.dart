import 'package:dio/dio.dart';
import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/requests/data/datasource/requests_datasource.dart';

class RequestsDatasourceImp implements RequestsDatasource {
  final ApiConsumer api;

  RequestsDatasourceImp({required this.api});

  @override
  Future<dynamic> addRequest({required Map<String, dynamic> body}) async {
    return await api.post(ApiEndpoints.addRequest, data: body);
  }

  @override
  Future<dynamic> uploadResult({required Map<String, dynamic> body}) async {
    String requestId = body['requestId'];
    String filePath = body['resultFileUrl'];

    FormData formData = FormData.fromMap({
      "requestId": requestId,
      "resultFileUrl": await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      ),
    });

    return await api.post(
      ApiEndpoints.uploadResult,
      data: formData,
      isFormated: true,
    );
  }
}