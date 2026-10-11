import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/order/data/datasource/checkout_datasource.dart';
import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';

class CheckoutDatasourceImp implements CheckoutDatasource {
  final ApiConsumer api;

  CheckoutDatasourceImp({required this.api});

  @override
  Future<dynamic> createOrder({required OrderRequestModel orderRequest}) async {
    return await api.post(ApiEndpoints.createOrder, data: orderRequest.toMap());
  }

  @override
  Future<dynamic> getOrders()async {
    return await api.get(ApiEndpoints.getOrders);
  }
}
