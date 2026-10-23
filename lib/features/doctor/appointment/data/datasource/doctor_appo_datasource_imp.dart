import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/appointment/data/datasource/doctor_appo_datasource.dart';

class DoctorAppoDatasourceImp implements DoctorAppoDatasource {
  final ApiConsumer api;

  DoctorAppoDatasourceImp({required this.api});

  @override
  Future<dynamic> getMyAppo() async {
    return await api.get(ApiEndpoints.doctorAppoGet);
  }

  @override
  Future<dynamic> addPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    return await api.post(
      ApiEndpoints.addPrescription,
      data: {
        'appointment': appointment,
        'diagnosis': diagnosis,
        'medicines': medicines,
        'labTests': labTests,
        'imaging': imaging,
        'nextVisit': nextVisit,
        'notes': notes,
      },
    );
  }

  @override
  Future<dynamic> completeAppo({required String appoId}) async {
    return await api.patch(ApiEndpoints.markAppoComplete(appoId));
  }

  @override
  Future<dynamic> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    return await api.patch(
      ApiEndpoints.editPrescription(appointment),
      data: {
        'appointment': appointment,
        'diagnosis': diagnosis,
        'medicines': medicines,
        'labTests': labTests,
        'imaging': imaging,
        'nextVisit': nextVisit,
        'notes': notes,
      },
    );
  }

  @override
  Future<dynamic> getPreviousPrescription({required String appoId}) async {
    return await api.get(ApiEndpoints.previousPrescription(appoId));
  }

  @override
  Future<dynamic> markAppoPaied({required String appoId}) async {
    return await api.patch(ApiEndpoints.markAppoPied(appoId));
  }
}
