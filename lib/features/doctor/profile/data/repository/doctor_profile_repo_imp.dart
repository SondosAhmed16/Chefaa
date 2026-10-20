import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/profile/data/datasource/doctor_profile_datasource.dart';
import 'package:chefaa/features/doctor/profile/data/model/doctor_profile_model/doctor_profile_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/update_profile_model/update_profile_model.dart';
import 'package:chefaa/features/doctor/profile/domain/repository/doctor_profile_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorProfileRepoImp implements DoctorProfileRepo {
  final DoctorProfileDatasource datasource;

  DoctorProfileRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, DoctorProfileModel>> getDoctorProfile() async {
    try {
      final response = await datasource.getDoctorProfile();
      final model = DoctorProfileModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
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
  ) async {
    try {
      final response = await datasource.updateDoctorProfile(
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
      final model = UpdateProfileModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
