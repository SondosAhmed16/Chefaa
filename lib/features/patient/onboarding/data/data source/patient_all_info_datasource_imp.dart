import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/onboarding/data/data%20source/patient_all_info_datasource.dart';
import 'package:chefaa/features/patient/onboarding/data/model/patient_all_info_model.dart';

class PatientAllInfoDatasourceImp implements PatientAllInfoDatasource {
  final ApiConsumer apiConsumer;

  PatientAllInfoDatasourceImp({required this.apiConsumer});

  @override
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
  }) async {
    final Map<String, dynamic> bodyData = {
      'age': age,
      'gender': gender?.toLowerCase(),
      'bloodType': bloodType,
      'allergies': allergies,
      'height': height,
      'weight': weight,
      'chronicConditions': chronicConditions,
    };

    if (phoneNumber != null) bodyData['phoneNumber'] = phoneNumber;
    if (addressText != null) bodyData['addressText'] = addressText;

    if (lng != null && lat != null) {
      bodyData['lng'] = lng;
      bodyData['lat'] = lat;
    }

    final res = await apiConsumer.put(ApiEndpoints.update_info, data: bodyData);

    return PatientAllInfoRes.fromJson(res);
  }
}
