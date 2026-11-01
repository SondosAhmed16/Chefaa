import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/pharmacy/orders/data/datasource/pharm_order_datasource.dart';

class PharmOrderDatasourceImp implements PharmOrderDatasource {
  final ApiConsumer api;

  PharmOrderDatasourceImp({required this.api});

  @override
  Future<dynamic> acceptOrder({required String orderId}) async {
    return await api.patch(ApiEndpoints.acceptOrder(orderId));
  }

  @override
  Future<dynamic> completeOrder({required String orderId}) async {
    return await api.patch(ApiEndpoints.completeOrder(orderId));
  }

  @override
  Future<dynamic> getOrders({String? status}) async {
    return await api.get(
      ApiEndpoints.getOrder,
      queryParam: {if (status != null && status.isNotEmpty) "status": status},
    );
  }

  @override
  Future<dynamic> readyOrder({required String orderId}) async {
    return await api.patch(
      ApiEndpoints.readyOrder(orderId),
      data: {"deliveryManId": null},
    );
  }
}
