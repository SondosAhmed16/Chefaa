import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/profile/data/data%20source/patient_profile_data_source.dart';
import 'package:chefaa/features/patient/profile/data/model/patient_profile_model.dart';

class PatientProfileDataSourceImp implements PatientProfileDataSource {
  final ApiConsumer api;

  PatientProfileDataSourceImp({required this.api});

  @override
  Future<PatientProfileModel> getProfileData() async {
    final response = await api.get(ApiEndpoints.getProfilePat);
    return PatientProfileModel.fromJson(response);
  }

  @override
  Future<PatientProfileModel> updateBasicInfo({
    String? name,
    num? age,
    String? gender,
    num? height,
    num? weight,
  }) async {
    final response = await api.put(
      ApiEndpoints.updateBasicInfo,
      data: {
        if (name != null) 'name': name,
        if (age != null) 'age': age,
        if (gender != null) 'gender': gender,
        if (height != null) 'height': height,
        if (weight != null) 'weight': weight,
      },
    );
    return PatientProfileModel.fromJson(response);
  }

  @override
  Future<PatientProfileModel> updateMedInfo({
    String? bloodType,
    List<String>? allergiesList,
    List<String>? chronicConditionsList,
  }) async {
    final response = await api.put(
      ApiEndpoints.updateMedInfo,
      data: {
        if (bloodType != null) 'bloodType': bloodType,
        if (allergiesList != null) 'allergies': allergiesList,
        if (chronicConditionsList != null)
          'chronicConditions': chronicConditionsList,
      },
    );
    return PatientProfileModel.fromJson(response);
  }
}
