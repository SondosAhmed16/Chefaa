import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepo {
  Future<Either<ErrorModel, AppointmentModel>> getPatientAppo();
}
