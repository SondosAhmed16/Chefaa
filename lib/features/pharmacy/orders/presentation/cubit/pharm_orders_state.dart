import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/get_orders_model/get_orders_model.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/order_stat_model/order_stat_model.dart';

sealed class PharmOrdersState {}

class PharmOrdersInitialState extends PharmOrdersState {}

class GetOrdersLoadingState extends PharmOrdersState {}

class GetOrdersSuccessState extends PharmOrdersState {
  final GetOrdersModel getOrdersModel;
  GetOrdersSuccessState(this.getOrdersModel);
}

class GetOrdersErrorState extends PharmOrdersState {
  final ErrorModel errorModel;
  GetOrdersErrorState(this.errorModel);
}

class AcceptOrderLoadingState extends PharmOrdersState {
  final String orderId;
  AcceptOrderLoadingState(this.orderId);
}

class AcceptOrderSuccessState extends PharmOrdersState {
  final OrderStatModel orderStatModel;
  AcceptOrderSuccessState(this.orderStatModel);
}

class AcceptOrderErrorState extends PharmOrdersState {
  final ErrorModel errorModel;
  AcceptOrderErrorState(this.errorModel);
}

class ReadyOrderLoadingState extends PharmOrdersState {
  final String orderId;
  ReadyOrderLoadingState(this.orderId);
}

class ReadyOrderSuccessState extends PharmOrdersState {
  final OrderStatModel orderStatModel;
  ReadyOrderSuccessState(this.orderStatModel);
}

class ReadyOrderErrorState extends PharmOrdersState {
  final ErrorModel errorModel;
  ReadyOrderErrorState(this.errorModel);
}

class CompleteOrderLoadingState extends PharmOrdersState {
  final String orderId;
  CompleteOrderLoadingState(this.orderId);
}

class CompleteOrderSuccessState extends PharmOrdersState {
  final OrderStatModel orderStatModel;
  CompleteOrderSuccessState(this.orderStatModel);
}

class CompleteOrderErrorState extends PharmOrdersState {
  final ErrorModel errorModel;
  CompleteOrderErrorState(this.errorModel);
}