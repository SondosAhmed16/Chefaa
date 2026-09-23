import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/reschedual_model_response.dart';
import 'package:chefaa/features/patient/appointment/domain/repository/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class ReschedualAppoUsecase {
  final AppointmentRepo repo;

  ReschedualAppoUsecase({required this.repo});

  Future<Either<ErrorModel, ReschedualModelResponse>> call({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  }) async {
    return await repo.reschedualAppo(
      appointmentId: appointmentId,
      date: date,
      slotStart: slotStart,
      slotEnd: slotEnd,
      timeChosed: timeChosed,
    );
  }
}
