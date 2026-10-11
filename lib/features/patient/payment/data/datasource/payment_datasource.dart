abstract class PaymentDatasource {
  Future<dynamic> paymentOnline({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  });
}
