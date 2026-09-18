import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/onboarding/domain/entity/patient_all_info_entity.dart';
import 'package:chefaa/features/patient/onboarding/domain/repository/patient_all_info_repo.dart';
import 'package:dartz/dartz.dart';

class PatientAllInfoUsacse {
  final PatientAllInfoRepo repo;

  PatientAllInfoUsacse({required this.repo});

  Future<Either<ErrorModel, PatientInfoResEntity>> call({
    String? addressText,
    double? lng,
    double? lat,
    String? phoneNumber,
    int? age,
    String? gender,
    String? bloodType,
    List<String>? allergies,
    double? height,
    double? weight,
    List<String>? chronicConditions,
  }) async {
    return await repo.updateAllInfo(
      addressText: addressText,
      lng: lng,
      lat: lat,
      phoneNumber: phoneNumber,
      age: age,
      gender: gender,
      bloodType: bloodType,
      allergies: allergies,
      height: height,
      weight: weight,
      chronicConditions: chronicConditions,
    );
  }
}
