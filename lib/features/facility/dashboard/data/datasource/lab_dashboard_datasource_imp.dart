import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/dashboard/data/datasource/lab_dashboard_datasource.dart';

class LabDashboardDatasourceImp implements LabDashboardDatasource {
  final ApiConsumer api;

  LabDashboardDatasourceImp({required this.api});

  @override
  Future<dynamic> getLabDashboard() async {
    return await api.get(ApiEndpoints.getCenterDashboard);
  }
}
