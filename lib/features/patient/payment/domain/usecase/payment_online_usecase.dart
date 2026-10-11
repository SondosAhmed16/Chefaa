import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/payment/data/model/payment_model.dart';
import 'package:chefaa/features/patient/payment/domain/repository/payment_repo.dart';
import 'package:dartz/dartz.dart';

class PaymentOnlineUsecase {
  final PaymentRepo repo;

  PaymentOnlineUsecase({required this.repo});

  Future<Either<ErrorModel, PaymentModel>> call({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    return await repo.paymentOnline(
      orderId: orderId,
      cardholderName: cardholderName,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvv: cvv,
    );
  }
}
