import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/requests/data/datasource/requests_datasource.dart';

class RequestsDatasourceImp implements RequestsDatasource{

  final ApiConsumer api;

  RequestsDatasourceImp({required this.api});

  @override
  Future<dynamic> addRequest({required Map<String, dynamic> body}) async{
    return await api.post(ApiEndpoints.addRequest,data: body);
  }
}