import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/profile/data/model/address.dart';
import 'package:chefaa/features/facility/profile/data/model/lab_profile_response.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';
import 'package:chefaa/features/facility/profile/domain/repository/lab_profile_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateLabProfileUsecase {
  final LabProfileRepo repo;

  UpdateLabProfileUsecase({required this.repo});

  Future<Either<ErrorModel, LabProfileResponse>> call({
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
    return await repo.updateLabProfile(
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
  }
}
