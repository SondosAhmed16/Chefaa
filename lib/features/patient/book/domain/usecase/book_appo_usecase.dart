import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/book/data/model/book_model.dart';
import 'package:chefaa/features/patient/book/domain/repository/book_appo_repo.dart';
import 'package:dartz/dartz.dart';

class BookAppoUsecase {
  final BookAppoRepo repo;

  BookAppoUsecase({required this.repo});

  Future<Either<ErrorModel, BookModel>> call({
    required String clinicId,
    required String date,
    required String time,
    required bool isFollowUp,
    required String paymentOption,
    required String paymentStatus,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardholderName,
  }) async {
    return await repo.bookAppo(
      clinicId: clinicId,
      date: date,
      time: time,
      isFollowUp: isFollowUp,
      paymentOption: paymentOption,
      paymentStatus: paymentStatus,
      cardNumber: cardNumber,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      cvv: cvv,
      cardholderName: cardholderName,
    );
  }
}
