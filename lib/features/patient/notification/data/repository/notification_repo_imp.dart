import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/notification/data/data%20source/notification_datasource.dart';
import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';
import 'package:chefaa/features/patient/notification/domain/repository/notification_repo.dart';
import 'package:dartz/dartz.dart';

class NotificationRepoImp implements NotificationRepo {
  final NotificationDatasource datasource;

  NotificationRepoImp({required this.datasource});
  @override
  Future<Either<ErrorModel, List<NotificationResponse>>> getNotification() async {
    try {
      final result = await datasource.getNotification();
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
