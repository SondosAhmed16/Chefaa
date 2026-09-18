import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/onboarding/domain/entity/patient_all_info_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PatientAllInfoRepo {
  Future<Either<ErrorModel, PatientInfoResEntity>> updateAllInfo({
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
  });
}
