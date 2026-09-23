import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/reschedual_model_response.dart';
import 'package:chefaa/features/patient/appointment/domain/repository/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class CancelAppointmentUsecase {
  final AppointmentRepo repo;

  CancelAppointmentUsecase({required this.repo});

  Future<Either<ErrorModel, ReschedualModelResponse>> call({
    required String appointmentId,
  }) async {
    return repo.cancelAppo(appointmentId: appointmentId);
  }
}
