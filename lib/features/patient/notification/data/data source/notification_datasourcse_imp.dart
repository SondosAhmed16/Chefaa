import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/notification/data/data%20source/notification_datasource.dart';
import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';

class NotificationDatasourcseImp implements NotificationDatasource {
  final ApiConsumer api;

  NotificationDatasourcseImp({required this.api});
  @override
  Future<List<NotificationResponse>> getNotification() async {
    final response = await api.get(ApiEndpoints.getNotification);
    final List<dynamic> jsonList = response; 
    return NotificationResponse.fromJsonList(jsonList);
  }
}
