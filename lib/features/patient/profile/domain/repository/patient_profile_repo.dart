import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PatientProfileRepo {
  Future<Either<ErrorModel, ProfilePatientEntity>> getProfileData();

  Future<Either<ErrorModel, ProfilePatientEntity>> updateBasicInfo({
    String? name,
    num? age,
    String? gender,
    num? height,
    num? weight,
  });

  Future<Either<ErrorModel, ProfilePatientEntity>> updateMedInfo({
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  });
}
