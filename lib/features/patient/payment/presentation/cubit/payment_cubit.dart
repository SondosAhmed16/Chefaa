import 'package:chefaa/features/patient/payment/domain/usecase/payment_online_usecase.dart';
import 'package:chefaa/features/patient/payment/presentation/cubit/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentOnlineUsecase usecase;

  PaymentCubit({required this.usecase}) : super(PaymentInitial());

  Future<void> paymentOnline({
    required String orderId,
    required String cardholderName,
    required String cardNumber,
    required String expiryDate,
    required String cvv,
  }) async {
    if (!isClosed) emit(PaymentLoading());
    final result = await usecase.call(
      orderId: orderId,
      cardholderName: cardholderName,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvv: cvv,
    );

    result.fold(
      (error) => emit(PaymentError(error: error)),
      (payment) => emit(PaymentSuccess(paymentModel: payment)),
    );
  }
}
