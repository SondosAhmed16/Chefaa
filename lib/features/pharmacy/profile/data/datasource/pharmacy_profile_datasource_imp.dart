import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/pharmacy/profile/data/datasource/pharmacy_profille_datasource.dart';

class PharmacyProfileDatasourceImp implements PharmacyProfilleDatasource {
  final ApiConsumer api;

  PharmacyProfileDatasourceImp({required this.api});
  @override
  Future<dynamic> getPharmacyProfile() async {
    return await api.get(ApiEndpoints.getPharmProfile);
  }

  @override
  Future<dynamic> updatePharmacyProfile({
    required Map<String, dynamic> body,
  }) async {
    return await api.patch(ApiEndpoints.updatePharmProfile, data: body);
  }

  @override
  Future<dynamic> updatePharmacySettings({
    required Map<String, dynamic> body,
  }) async {
    return await api.patch(ApiEndpoints.updatePharmSettings, data: body);
  }
}
