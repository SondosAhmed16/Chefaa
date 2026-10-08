import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/datasource/pharmacy_search_datasource.dart';

class PharmacySearchDatasourceImp implements PharmacySearchDatasource {
  final ApiConsumer api;

  PharmacySearchDatasourceImp({required this.api});

  @override
  Future<dynamic> searchPharmacy({required String searchQuery}) async {
    final Map<String, dynamic> params = {"type": "pharmacy"};

    if (searchQuery.trim().isNotEmpty) {
      params["query"] = searchQuery.trim();
    }

    return await api.get(ApiEndpoints.searchPharmacy, queryParam: params);
  }

  @override
  Future<dynamic> getPharmacyProfile({required String pharmacyId}) async {
    return await api.get(ApiEndpoints.getPharmacyProfile(pharmacyId));
  }

  @override
  Future<dynamic> getPharmacyMedicines({required String pharmacyId}) async {
    return await api.get(ApiEndpoints.getPharmacyMediciens(pharmacyId));
  }
}
