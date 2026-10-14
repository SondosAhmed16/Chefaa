import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/profile/data/model/address.dart';
import 'package:chefaa/features/facility/profile/data/model/lab_profile_response.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';
import 'package:dartz/dartz.dart';

abstract class LabProfileRepo {
  Future<Either<ErrorModel, LabProfileResponse>> getLabProfile();
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
  });
}
