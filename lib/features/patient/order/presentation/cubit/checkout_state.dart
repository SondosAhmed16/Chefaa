import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/order/data/model/order_model/order_model.dart';

sealed class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutSuccess extends CheckoutState {
  final OrderModel orderModel;
  CheckoutSuccess(this.orderModel);
}

class CheckoutFailure extends CheckoutState {
  final ErrorModel message;
  CheckoutFailure(this.message);
}
