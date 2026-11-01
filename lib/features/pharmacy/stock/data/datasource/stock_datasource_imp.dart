import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/pharmacy/stock/data/datasource/stock_datasource.dart';

class StockDatasourceImp implements StockDatasource {
  final ApiConsumer api;

  StockDatasourceImp({required this.api});

  @override
  Future<dynamic> addMed({required Map<String, dynamic> body}) async {
    return await api.post(ApiEndpoints.addMedicine, data: body);
  }

  @override
  Future<dynamic> getMed({String? filter}) async {
    return await api.get(
      ApiEndpoints.getStock,
      queryParam: {if (filter != null && filter.isNotEmpty) "filter": filter},
    );
  }

  @override
  Future<dynamic> restock({
    required String medId,
    required Map<String, dynamic> body,
  }) async {
    return await api.put(ApiEndpoints.restok(medId), data: body);
  }
}
