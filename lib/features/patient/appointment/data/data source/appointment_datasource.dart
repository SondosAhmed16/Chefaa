import 'package:chefaa/features/patient/appointment/data/model/appointment_model.dart';

abstract class AppointmentDatasource {
  Future<AppointmentModel> getPatientAppo();
}
