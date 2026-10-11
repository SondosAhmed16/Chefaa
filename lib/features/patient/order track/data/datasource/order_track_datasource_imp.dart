import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/order%20track/data/datasource/order_track_datasource.dart';

class OrderTrackDatasourceImp implements OrderTrackDatasource {
  final ApiConsumer api;

  OrderTrackDatasourceImp({required this.api});

  @override
  Future<dynamic> orderTrack({required String orderId}) async {
    return await api.get(ApiEndpoints.getOrderTrack(orderId));
  }

  @override
  Future<dynamic> orderConfirm({required String orderId}) async {
    return await api.post(
      ApiEndpoints.confirmOrder,
      data: {"orderId": orderId},
    );
  }
}
