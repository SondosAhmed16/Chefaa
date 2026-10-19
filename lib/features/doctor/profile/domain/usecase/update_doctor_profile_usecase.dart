import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/update_profile_model/update_profile_model.dart';
import 'package:chefaa/features/doctor/profile/domain/repository/doctor_profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateDoctorProfileUsecase {
  final DoctorProfileRepo repo;

  UpdateDoctorProfileUsecase({required this.repo});

  Future<Either<ErrorModel, UpdateProfileModel>> call(
  
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
    return await repo.updateDoctorProfile(
      specialization,
      location,
      imageUrl,
      clinics,
      rating,
      reviews,
      yearsOfExperience,
      about,
      age,
      paymentOption,
      gender,
      contactNumber,
      degrees,
      prePaymentNumbers,
      clinicConsultationPrice,
    );
  }
}
