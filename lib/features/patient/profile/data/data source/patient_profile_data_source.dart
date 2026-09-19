import 'package:chefaa/features/patient/profile/data/model/patient_profile_model.dart';

abstract class PatientProfileDataSource {
  Future<PatientProfileModel> getProfileData();

  Future<PatientProfileModel> updateBasicInfo({
    String? name,
    num? age,
    String? gender,
    num? height,
    num? weight,
  });

  Future<PatientProfileModel> updateMedInfo({
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  });
}
