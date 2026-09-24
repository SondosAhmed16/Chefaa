import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/reschedual_model_response.dart';

abstract class AppointmentDatasource {
  Future<AppointmentModel> getPatientAppo();

  Future<ReschedualModelResponse> reschedualAppo({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  });

  Future<ReschedualModelResponse> cancelApoo({required String appointmentId});
}
