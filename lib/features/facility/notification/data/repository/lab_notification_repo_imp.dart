import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/notification/data/datasource/lab_notification_datasource.dart';
import 'package:chefaa/features/facility/notification/data/model/lab_notification_model.dart';
import 'package:chefaa/features/facility/notification/domain/repository/lab_notification_repo.dart';
import 'package:dartz/dartz.dart';

class LabNotificationRepoImp implements LabNotificationRepo {
  final LabNotificationDatasource datasource;

  LabNotificationRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, LabNotificationModel>> getLabNotification() async {
    try {
      final response = await datasource.getLabNotification();
      final model = LabNotificationModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
