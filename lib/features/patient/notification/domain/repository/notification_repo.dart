import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepo {

  Future<Either<ErrorModel,List<NotificationResponse>>> getNotification();
}