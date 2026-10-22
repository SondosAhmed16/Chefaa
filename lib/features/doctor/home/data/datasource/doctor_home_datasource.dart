abstract class DoctorHomeDatasource {
  Future<dynamic> getDoctorClinics({required String doctorId});
  Future<dynamic> getMyClinic({required String clinicId});
  Future<dynamic> deleteMyClinic({required String clinicId});
  Future<dynamic> updateClinic({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });

  Future<dynamic> addClinic({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });
}
