import 'dart:async';

import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/appointment/data/data%20source/appointment_datasource.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';
import 'package:chefaa/features/patient/appointment/data/model/reschedual_model_response.dart';

class AppointmentDatasourcseImp implements AppointmentDatasource {
  final ApiConsumer api;

  AppointmentDatasourcseImp({required this.api});

  @override
  Future<AppointmentModel> getPatientAppo() async {
    final response = await api.get(ApiEndpoints.getPatientAppo);
    return AppointmentModel.fromMap(response);
  }

  @override
  Future<ReschedualModelResponse> reschedualAppo({
    required String appointmentId,
    required String date,
    required String slotStart,
    required String slotEnd,
    required String timeChosed,
  }) async {
    final response = await api.patch(
      ApiEndpoints.reschedualAppointment(appointmentId),
      data: {
        "date": date,
        "slotStart": slotStart,
        "slotEnd": slotEnd,
        "timeChosed": timeChosed,
      },
    );
    return ReschedualModelResponse.fromMap(response);
  }

  @override
  Future<ReschedualModelResponse> cancelApoo({
    required String appointmentId,
  }) async {
    final response = await api.patch(
      ApiEndpoints.cancelAppointment(appointmentId),
    );

    return ReschedualModelResponse.fromMap(response);
  }
}
