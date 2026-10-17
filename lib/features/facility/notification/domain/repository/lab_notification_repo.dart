import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/notification/data/model/lab_notification_model.dart';
import 'package:dartz/dartz.dart';

abstract class LabNotificationRepo {

Future<Either<ErrorModel,LabNotificationModel>> getLabNotification();

}