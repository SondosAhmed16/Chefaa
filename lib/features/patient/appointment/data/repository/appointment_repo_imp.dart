import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/appointment/data/data%20source/appointment_datasource.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:chefaa/features/patient/appointment/domain/repository/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class AppointmentRepoImp implements AppointmentRepo {
  final AppointmentDatasource datasource;

  AppointmentRepoImp({required this.datasource});
  @override
  Future<Either<ErrorModel, AppointmentModel>> getPatientAppo() async {
    try {
      final result = await datasource.getPatientAppo();
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
