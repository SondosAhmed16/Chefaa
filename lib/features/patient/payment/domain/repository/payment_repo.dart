import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/payment/data/model/payment_model.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentRepo {
  Future<Either<ErrorModel, PaymentModel>> paymentOnline({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  });
}
