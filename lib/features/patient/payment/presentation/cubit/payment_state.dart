import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/payment/data/model/payment_model.dart';

sealed class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final PaymentModel paymentModel;

  PaymentSuccess({required this.paymentModel});
}

class PaymentError extends PaymentState {
  final ErrorModel error;

  PaymentError({required this.error});
}
