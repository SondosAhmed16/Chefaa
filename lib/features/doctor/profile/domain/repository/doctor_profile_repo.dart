import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/doctor_profile_model/doctor_profile_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/update_profile_model/update_profile_model.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorProfileRepo {
  Future<Either<ErrorModel, DoctorProfileModel>> getDoctorProfile();
  Future<Either<ErrorModel, UpdateProfileModel>> updateDoctorProfile(
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
