import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/profile/data/datasource/lab_profile_datasource.dart';
import 'package:chefaa/features/facility/profile/data/model/address.dart';
import 'package:chefaa/features/facility/profile/data/model/lab_profile_response.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';
import 'package:chefaa/features/facility/profile/domain/repository/lab_profile_repo.dart';
import 'package:dartz/dartz.dart';

class LabProfileRepoImp implements LabProfileRepo {
  final LabProfileDatasource datasource;

  LabProfileRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, LabProfileResponse>> getLabProfile() async {
    try {
      final response = await datasource.getLabProfile();

      if (response == null || response is! Map<String, dynamic>) {
        return Left(ErrorModel(message: "Invalid server response format"));
      }

      final model = LabProfileResponse.fromMap(response);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, LabProfileResponse>> updateLabProfile({
    String? name,
    String? phoneNumber,
    String? facilityType,
    WorkingHours? workingHours,
    String? commercialRegisterNumber,
    String? licenseValidUntil,
    String? medicalDirectorName,
    String? directorProfessionalId,
    bool? homeSampleCollection,
    bool? aiRecommendations,
    bool? insuranceAccepted,
    List<String>? paymentMethods,
    List<Address>? addresses,
  }) async {
    try {
      final response = await datasource.updateLabProfile(
        phoneNumber: phoneNumber,
        facilityType: facilityType,
        workingHours: workingHours,
        commercialRegisterNumber: commercialRegisterNumber,
        licenseValidUntil: licenseValidUntil,
        medicalDirectorName: medicalDirectorName,
        directorProfessionalId: directorProfessionalId,
        homeSampleCollection: homeSampleCollection,
        aiRecommendations: aiRecommendations,
        insuranceAccepted: insuranceAccepted,
        paymentMethods: paymentMethods,
        addresses: addresses,
        name: name,
      );

      if (response == null || response is! Map<String, dynamic>) {
        return Left(ErrorModel(message: "Invalid server response format"));
      }

      final model = LabProfileResponse.fromMap(response);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
