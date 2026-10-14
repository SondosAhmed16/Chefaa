import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/profile/data/datasource/lab_profile_datasource.dart';
import 'package:chefaa/features/facility/profile/data/model/address.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';

class LabProfileDatasourceImp implements LabProfileDatasource {
  final ApiConsumer api;

  LabProfileDatasourceImp({required this.api});

  @override
  Future<dynamic> getLabProfile() async {
    return await api.get(ApiEndpoints.getLabProfile);
  }

  @override
  Future<dynamic> updateLabProfile({
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
    return await api.patch(
      ApiEndpoints.updateLabProfile,
      data: {
        'name': name,
        'phoneNumber': phoneNumber,
        'facilityType': facilityType,
        'workingHours': workingHours?.toMap(),
        'commercialRegisterNumber': commercialRegisterNumber,
        'licenseValidUntil': licenseValidUntil,
        'medicalDirectorName': medicalDirectorName,
        'directorProfessionalId': directorProfessionalId,
        'homeSampleCollection': homeSampleCollection,
        'aiRecommendations': aiRecommendations,
        'insuranceAccepted': insuranceAccepted,
        'paymentMethods': paymentMethods,
        'addresses': addresses?.map((e) => e.toMap()).toList(),
      },
    );
  }
}
