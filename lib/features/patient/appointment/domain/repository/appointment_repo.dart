import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/reschedual_model_response.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepo {
  Future<Either<ErrorModel, AppointmentModel>> getPatientAppo();

  Future<Either<ErrorModel, ReschedualModelResponse>> reschedualAppo({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  });

  Future<Either<ErrorModel,ReschedualModelResponse>> cancelAppo({required String appointmentId,});
}
