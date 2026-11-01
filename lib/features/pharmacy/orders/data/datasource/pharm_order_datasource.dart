abstract class PharmOrderDatasource {
  Future<dynamic> getOrders({String? status});
  Future<dynamic> acceptOrder({required String orderId});
  Future<dynamic> readyOrder({required String orderId});
  Future<dynamic> completeOrder({required String orderId});
}
