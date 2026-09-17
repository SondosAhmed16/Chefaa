import 'package:chefaa/features/patient/auth/data/model/register_patient_model.dart';

abstract class DataSourcePatientAuth {
  Future<RegisterPatientModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  });
}
