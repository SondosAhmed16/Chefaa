import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/home/data/datasource/doctor_home_datasource.dart';

class DoctorHomeDatasourceImp implements DoctorHomeDatasource {
  final ApiConsumer api;

  DoctorHomeDatasourceImp({required this.api});

  @override
  Future<dynamic> getDoctorClinics({required String doctorId}) async {
    return await api.get(ApiEndpoints.getDoctorClinic(doctorId));
  }

  @override
  Future<dynamic> getMyClinic({required String clinicId}) async {
    return await api.get(ApiEndpoints.getMyClinic(clinicId));
  }

  @override
  Future<dynamic> deleteMyClinic({required String clinicId}) async {
    return await api.delete(ApiEndpoints.deleteMyClinic(clinicId));
  }

  @override
  Future<dynamic> updateClinic({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) async {
    return await api.put(
      ApiEndpoints.updateMyClinic(clinicID),
      data: {
        "name": name,
        "address": address,
        "city": city,
        "price": price,
        "operatingLicense": operatingLicense,
        "location": location,
        "schedule": schedule,
      },
    );
  }

  @override
  Future<dynamic> addClinic({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) async {
    return await api.post(
      ApiEndpoints.addClinic,
      data: {
        "name": name,
        "address": address,
        "city": city,
        "price": price,
        "operatingLicense": operatingLicense,
        "location": location,
        "schedule": schedule,
      },
    );
  }
}
