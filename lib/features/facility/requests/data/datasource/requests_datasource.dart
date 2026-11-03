abstract class RequestsDatasource {
  Future<dynamic> addRequest({required Map<String, dynamic> body});
  Future<dynamic> uploadResult({required Map<String, dynamic> body});
}
