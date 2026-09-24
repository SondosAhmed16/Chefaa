import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';

sealed class NotificationState {}

class NotificationInitState extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationErrorState extends NotificationState {
  final String errorMessage;

  NotificationErrorState({required this.errorMessage});
}

class NotificationSuccessState extends NotificationState {
  final List<NotificationResponse> notification;

  NotificationSuccessState({required this.notification});
}
