import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order%20track/data/model/confirm_order/confirm_order.dart';
import 'package:chefaa/features/patient/order%20track/data/model/order_track_model.dart';

sealed class OrderTrackState {}

class OrderTrackInitial extends OrderTrackState {}

class OrderTrackLoading extends OrderTrackState {}

class OrderTrackSuccess extends OrderTrackState {
  final OrderTrackModel model;

  OrderTrackSuccess({required this.model});
}

class OrderTrackError extends OrderTrackState {
  final ErrorModel error;

  OrderTrackError({required this.error});
}

class OrderConfirmLoading extends OrderTrackState {}

class OrderConfirmSuccess extends OrderTrackState {
  final ConfirmOrder model;

  OrderConfirmSuccess({required this.model});
}

class OrderConfirmError extends OrderTrackState {
  final ErrorModel error;

  OrderConfirmError({required this.error});
}
