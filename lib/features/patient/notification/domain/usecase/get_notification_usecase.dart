import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';
import 'package:chefaa/features/patient/notification/domain/repository/notification_repo.dart';
import 'package:dartz/dartz.dart';

class GetNotificationUsecase {

  final NotificationRepo repo;

  GetNotificationUsecase({required this.repo});

  Future<Either<ErrorModel,List<NotificationResponse>>>call()async{
    return await repo.getNotification();
  }
}