abstract class ApiConsumer {
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParam,
    bool isFormated = false,
  });
}
