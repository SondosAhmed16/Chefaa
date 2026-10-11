import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/payment/data/datasource/payment_datasource.dart';
import 'package:chefaa/features/patient/payment/data/model/payment_model.dart';
import 'package:chefaa/features/patient/payment/domain/repository/payment_repo.dart';
import 'package:dartz/dartz.dart';

class PaymentRepoImp implements PaymentRepo {
  final PaymentDatasource datasource;

  PaymentRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, PaymentModel>> paymentOnline({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    try {
      final response = await datasource.paymentOnline(
        orderId: orderId,
        cardholderName: cardholderName,
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
      );
      if (response is PaymentModel) {
        return Right(response);
      }
      final model = PaymentModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
