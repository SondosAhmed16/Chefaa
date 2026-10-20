import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/doctor_profile_model/doctor_profile_model.dart';
import 'package:chefaa/features/doctor/profile/domain/repository/doctor_profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetDoctorProfileUsecase {
  final DoctorProfileRepo repo;

  GetDoctorProfileUsecase({required this.repo});

  Future<Either<ErrorModel, DoctorProfileModel>> call() async {
    return await repo.getDoctorProfile();
  }
}
