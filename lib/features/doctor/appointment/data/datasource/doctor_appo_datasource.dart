abstract class DoctorAppoDatasource {
  Future<dynamic> getMyAppo();
  Future<dynamic> addPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  });
  Future<dynamic> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  });
  Future<dynamic> getPreviousPrescription({required String appoId});
  Future<dynamic> completeAppo({required String appoId});
  Future<dynamic> markAppoPaied({required String appoId});
}
