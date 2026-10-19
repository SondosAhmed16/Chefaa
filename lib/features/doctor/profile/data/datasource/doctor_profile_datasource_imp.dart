import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/profile/data/datasource/doctor_profile_datasource.dart';
import 'package:dio/dio.dart';

class DoctorProfileDatasourceImp implements DoctorProfileDatasource {
  final ApiConsumer api;

  DoctorProfileDatasourceImp({required this.api});

  @override
  Future<dynamic> getDoctorProfile() async {
    return await api.get(ApiEndpoints.getDoctorProfile);
  }

  @override
  Future<dynamic> updateDoctorProfile(
    String? specialization,
    String? location,
    String? imageUrl,
    int? clinics,
    double? rating,
    int? reviews,
    int? yearsOfExperience,
    String? about,
    int? age,
    String? paymentOption,
    String? gender,
    String? contactNumber,
    List<dynamic>? degrees,
    List<dynamic>? prePaymentNumbers,
    num? clinicConsultationPrice,
  ) async {
    Map<String, dynamic> body = {
      'specialization': specialization,
      'about': about,
      'age': age,
      'yearsOfExperience': yearsOfExperience,
      'contactNumber': contactNumber,
      'clinicConsultationPrice': clinicConsultationPrice,
      'gender': gender,
      'paymentOption': paymentOption,
      'degrees': degrees,
      'prePaymentNumbers': prePaymentNumbers ?? [],
    };

    if (imageUrl != null && !imageUrl.startsWith('http')) {
      body['image'] = await MultipartFile.fromFile(imageUrl);
    }

    FormData formData = FormData.fromMap(body);

    return await api.put(
      ApiEndpoints.updateDoctorProfile,
      data: formData,
      isFormated: true,
    );
  }
}
