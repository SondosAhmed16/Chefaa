import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/payment/data/datasource/payment_datasource.dart';
import 'package:chefaa/features/patient/payment/data/model/payment_model.dart';

class PaymentOnlineImp implements PaymentDatasource {
  final ApiConsumer api;

  PaymentOnlineImp({required this.api});

  @override
  Future<dynamic> paymentOnline({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    final response = await api.post(
      ApiEndpoints.paymentProcess,
      data: {
        'orderId': orderId,
        'cardholderName': cardholderName,
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cvv': cvv,
      },
    );
    return PaymentModel.fromMap(response);
  }
}
