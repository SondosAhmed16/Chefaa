import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:chefaa/features/patient/appointment/domain/repository/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class GetPatientAppo {
  final AppointmentRepo repo;

  GetPatientAppo({required this.repo});

  Future<Either<ErrorModel, AppointmentModel>> call() async {
    return await repo.getPatientAppo();
  }
}
