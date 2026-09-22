import 'package:chefaa/features/patient/onboarding/data/model/patient_all_info_model.dart';

abstract class PatientAllInfoDatasource {
  Future<PatientAllInfoRes> updateAllInfo({
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
