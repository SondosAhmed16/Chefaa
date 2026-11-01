abstract class PharmacyProfilleDatasource {
  Future<dynamic> getPharmacyProfile();
  Future<dynamic> updatePharmacyProfile({required Map<String, dynamic> body});
  Future<dynamic> updatePharmacySettings({required Map<String, dynamic> body});
}
