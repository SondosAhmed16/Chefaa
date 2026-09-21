import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/medication/data/data%20source/medication_datasourcse.dart';
import 'package:dio/src/response.dart';

class MedicationDatasourceImp implements MedicationDataSource {
  final ApiConsumer api;

  MedicationDatasourceImp({required this.api});

  @override
  Future<Response> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async {
    return await api.post(
      ApiEndpoints.addMedication,
      data: {
        'name': name,
        'dosage': dosage,
        'form': form,
        'timesPerDay': timesPerDay,
        'schedule': schedule,
        'startDate': startDate,
        'endDate': endDate,
        'isActive': isActive,
      },
    );
  }

  @override
  Future<Response<dynamic>> confirmMedication(String medicationId) async {
    return await api.post(ApiEndpoints.confirmMedication(medicationId));
  }

  @override
  Future<dynamic> deleteMedication(String medicationId) async {
    return await api.delete(ApiEndpoints.deleteMedication(medicationId));
  }

  @override
  Future<dynamic> getMedicationList() async {
    return await api.get(ApiEndpoints.getMedication);
  }

  @override
  Future<Response<dynamic>> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async {
    return await api.put(
      ApiEndpoints.updateMedication(medicationId),
      data: {
        'name': name,
        'dosage': dosage,
        'form': form,
        'timesPerDay': timesPerDay,
        'schedule': schedule,
        'startDate': startDate,
        'endDate': endDate,
        'isActive': isActive,
      },
    );
  }
}
