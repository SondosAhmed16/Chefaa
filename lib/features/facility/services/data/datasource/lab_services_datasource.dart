abstract class LabServicesDatasource {
  Future<dynamic> getCenterServices();
  Future<dynamic> toggleService({required String serviceId});
}
