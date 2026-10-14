import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/services/data/datasource/lab_services_datasource.dart';

class LabServicesDatasourceImp implements LabServicesDatasource{

final ApiConsumer api;

  LabServicesDatasourceImp({required this.api});

  @override
  Future<dynamic> getCenterServices() async{
   return await api.get(ApiEndpoints.getCenterServices);
  }


}