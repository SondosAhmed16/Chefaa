import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/lab%20results/data/datasource/lab_result_datasource.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/lab_result_model.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';

class LabResultDatasourceImp implements LabResultDatasource {
  final ApiConsumer api;

  LabResultDatasourceImp({required this.api});

  @override
  Future<List<Result>> getLabResults() async {
    final response = await api.get(ApiEndpoints.getLabResults);
    final model = LabResultModel.fromMap(response as Map<String, dynamic>);
    return model.results ?? [];
  }
}
