import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:chefaa/features/patient/profile/domain/repository/patient_profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateBasicInfoUsecase {
  final PatientProfileRepo repo;

  UpdateBasicInfoUsecase({required this.repo});

  Future<Either<ErrorModel, ProfilePatientEntity>> call({
    String? name,
    num? age,
    String? gender,
    num? height,
    num? weight,
  }) async {
    return await repo.updateBasicInfo(
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
    );
  }
}
