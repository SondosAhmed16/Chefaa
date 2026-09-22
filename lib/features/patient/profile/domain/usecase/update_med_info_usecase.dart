import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:chefaa/features/patient/profile/domain/repository/patient_profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateMedInfoUsecase {
  final PatientProfileRepo repo;

  UpdateMedInfoUsecase({required this.repo});

  Future<Either<ErrorModel, ProfilePatientEntity>> call({
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  }) async {
    return await repo.updateMedInfo(
      bloodType: bloodType,
      allergiesList: allergiesList,
      chronicConditionsList: chronicConditionsList,
    );
  }
}
