import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/onboarding/data/data%20source/patient_all_info_datasource.dart';
import 'package:chefaa/features/patient/onboarding/domain/entity/patient_all_info_entity.dart';
import 'package:chefaa/features/patient/onboarding/domain/repository/patient_all_info_repo.dart';
import 'package:dartz/dartz.dart';

class PatientAllInfoRepoImp implements PatientAllInfoRepo {
  final PatientAllInfoDatasource datasource;

  PatientAllInfoRepoImp({required this.datasource});

  @override
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
  }) async {
    try {
      final response = await datasource.updateAllInfo(
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
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
