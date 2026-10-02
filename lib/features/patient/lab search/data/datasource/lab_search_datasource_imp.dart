import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/lab%20search/data/datasource/lab_search_datasource.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/lab_search_model.dart';

class LabSearchDatasourceImp implements LabSearchDatasource {
  final ApiConsumer api;

  LabSearchDatasourceImp({required this.api});

  @override
  Future<List<CenterModel>> searchLab({
    String? requiredServices,
    bool? homeService,
  }) async {
    final Map<String, dynamic> queryParams = {};
    if (requiredServices != null && requiredServices.isNotEmpty) {
      queryParams["requiredServices"] = requiredServices;
    }
    if (homeService != null) {
      queryParams["homeService"] = homeService;
    }

    final response = await api.get(
      ApiEndpoints.searchLab,
      queryParam: queryParams,
    );

    final labSearchModel = LabSearchModel.fromMap(
      response as Map<String, dynamic>,
    );
    return labSearchModel.centers ?? [];
  }
}
