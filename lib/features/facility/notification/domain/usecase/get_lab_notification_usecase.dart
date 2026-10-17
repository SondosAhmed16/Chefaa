import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/notification/data/model/lab_notification_model.dart';
import 'package:chefaa/features/facility/notification/domain/repository/lab_notification_repo.dart';
import 'package:dartz/dartz.dart';

class GetLabNotificationUsecase {
  final LabNotificationRepo repo;

  GetLabNotificationUsecase({required this.repo});

  Future<Either<ErrorModel, LabNotificationModel>> call() async {
    return await repo.getLabNotification();
  }
}
