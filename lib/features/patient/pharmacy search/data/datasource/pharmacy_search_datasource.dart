
abstract class PharmacySearchDatasource {
  Future<dynamic> searchPharmacy({required String searchQuery});
  Future<dynamic> getPharmacyProfile({required String pharmacyId});
  Future<dynamic> getPharmacyMedicines({required String pharmacyId});
}
