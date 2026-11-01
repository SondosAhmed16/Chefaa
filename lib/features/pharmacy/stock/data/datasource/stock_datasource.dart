abstract class StockDatasource {
  Future<dynamic> addMed({required Map<String, dynamic> body});
  Future<dynamic> getMed({String? filter});
  Future<dynamic> restock({
    required String medId,
    required Map<String, dynamic> body,
  });
}
