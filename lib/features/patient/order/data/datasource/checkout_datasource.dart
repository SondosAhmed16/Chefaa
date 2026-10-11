import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';

abstract class CheckoutDatasource {
  Future<dynamic> createOrder({required OrderRequestModel orderRequest});
  Future<dynamic> getOrders();
}
