abstract class MedicationDataSource {
  Future<dynamic> getMedicationList();

  Future<dynamic> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  });

  Future<dynamic> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  });

  Future<dynamic> deleteMedication(String medicationId);

  Future<dynamic> confirmMedication(String medicationId);
}
