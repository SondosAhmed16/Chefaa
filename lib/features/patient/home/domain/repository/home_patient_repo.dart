import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/home/domain/entity/appointment_entity.dart';
import 'package:dartz/dartz.dart';

abstract class HomePatientRepo {

  Future<Either<ErrorModel, List<AppointmentEntity>>> getUpcommingApp();

  Future<Either<ErrorModel, void>> confirmMedicationTaken(String medicationId);
}
