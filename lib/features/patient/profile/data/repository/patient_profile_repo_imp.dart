import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/profile/data/data%20source/patient_profile_data_source.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';
import 'package:chefaa/features/patient/profile/domain/repository/patient_profile_repo.dart';
import 'package:dartz/dartz.dart';

class PatientProfileRepoImp implements PatientProfileRepo{

  final PatientProfileDataSource dataSource;

  PatientProfileRepoImp({required this.dataSource});
 @override
  Future<Either<ErrorModel, ProfilePatientEntity>> getProfileData() async {
    try {
      final remoteData = await dataSource.getProfileData();
      return Right(remoteData);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ProfilePatientEntity>> updateBasicInfo({
    String? name,
    num? age,
    String? gender,
    num? height,
    num? weight,
  }) async {
    try {
      final remoteData = await dataSource.updateBasicInfo(
        name: name,
        age: age,
        gender: gender,
        height: height,
        weight: weight,
      );
      return Right(remoteData);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ProfilePatientEntity>> updateMedInfo({
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  }) async {
    try {
      final remoteData = await dataSource.updateMedInfo(
        bloodType: bloodType,
        allergiesList: allergiesList,
        chronicConditionsList: chronicConditionsList,
      );
      return Right(remoteData);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}