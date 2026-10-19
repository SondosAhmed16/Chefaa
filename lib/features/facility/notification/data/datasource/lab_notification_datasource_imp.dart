import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/notification/data/datasource/lab_notification_datasource.dart';

class LabNotificationDatasourceImp implements LabNotificationDatasource {
  final ApiConsumer api;

  LabNotificationDatasourceImp({required this.api});

  @override
  Future<dynamic> getLabNotification() async {
    return await api.get(ApiEndpoints.getCenterNotification);
  }
}
