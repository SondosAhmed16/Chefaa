import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';

abstract class NotificationDatasource {

  Future<List<NotificationResponse>> getNotification();
}