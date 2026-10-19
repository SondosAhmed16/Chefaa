
abstract class DoctorProfileDatasource {
  Future<dynamic> getDoctorProfile();
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
  );
}
