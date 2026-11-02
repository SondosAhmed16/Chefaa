abstract class LabServicesDatasource {
  Future<dynamic> getCenterServices();
  Future<dynamic> toggleService({required String serviceId});
  Future<dynamic> addService({required Map<String, dynamic> body});
}
