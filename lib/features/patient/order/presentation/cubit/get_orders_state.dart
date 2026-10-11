import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order/data/model/get_orders/get_orders.dart';

sealed class GetOrdersState {}

class GetOrdersInitial extends GetOrdersState {}

class GetOrdersLoading extends GetOrdersState {}

class GetOrdersSuccess extends GetOrdersState {
  final GetOrders orders;

  GetOrdersSuccess({required this.orders});
}

class GetOrdersError extends GetOrdersState {
  final ErrorModel error;

  GetOrdersError({required this.error});
}
