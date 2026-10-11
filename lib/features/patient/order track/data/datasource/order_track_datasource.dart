abstract class OrderTrackDatasource {
  Future<dynamic> orderTrack({required String orderId});
  Future<dynamic> orderConfirm({required String orderId});
}
