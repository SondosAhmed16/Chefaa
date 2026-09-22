import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/appointment/data/data%20source/appointment_datasource.dart';
import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';

class AppointmentDatasourcseImp implements AppointmentDatasource {
  final ApiConsumer api;

  AppointmentDatasourcseImp({required this.api});

  @override
  Future<AppointmentModel> getPatientAppo() async {
    final response = await api.get(ApiEndpoints.getPatientAppo);
    return AppointmentModel.fromMap(response);
  }
}
