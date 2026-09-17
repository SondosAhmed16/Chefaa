import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/auth/data/data%20source/data_source_patient_auth.dart';
import 'package:chefaa/features/patient/auth/data/model/register_patient_model.dart';

class DataSourcePatientAuthImplement implements DataSourcePatientAuth {
  final ApiConsumer apiConsumer;

  DataSourcePatientAuthImplement({required this.apiConsumer});

  @override
  Future<RegisterPatientModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.register,
      data: {
        "name": name,
        "username": userName,
        "email": email,
        "password": password,
        "phoneNumber": phone,
        "role": role,
      },
    );
    return RegisterPatientModel.fromJson(response);
  }
}
