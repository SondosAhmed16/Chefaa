import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:chefaa/features/patient/profile/domain/repository/patient_profile_repo.dart';
import 'package:dartz/dartz.dart';

class GetProfileUsecase {
  final PatientProfileRepo repo;

  GetProfileUsecase({required this.repo});

  Future<Either<ErrorModel, ProfilePatientEntity>> call() async {
    return await repo.getProfileData();
  }
}
