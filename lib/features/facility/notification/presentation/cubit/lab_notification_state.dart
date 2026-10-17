import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/notification/data/model/lab_notification_model.dart';

sealed class LabNotificationState {}

class LabNotificationInitial extends LabNotificationState {}

class LabNotificationLoading extends LabNotificationState {}

class LabNotificationSuccess extends LabNotificationState {
  final LabNotificationModel notification;

  LabNotificationSuccess({required this.notification});
}

class LabNotificationError extends LabNotificationState {
  final ErrorModel error;

  LabNotificationError({required this.error});
}
