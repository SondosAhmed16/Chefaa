import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/book/data/data%20source/book_appo_datasource.dart';
import 'package:chefaa/features/patient/book/data/model/book_model.dart';
import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';
import 'package:chefaa/features/patient/book/domain/repository/book_appo_repo.dart';
import 'package:dartz/dartz.dart';

class BookAppoRepoImp implements BookAppoRepo {
  final BookAppoDatasource datasource;

  BookAppoRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, BookModel>> bookAppo({
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
    try {
      final result = await datasource.bookAppo(
        clinicId: clinicId,
        date: date,
        time: time,
        isFollowUp: isFollowUp,
        paymentOption: paymentOption,
        cardNumber: cardNumber,
        expiryMonth: expiryMonth,
        expiryYear: expiryYear,
        cvv: cvv,
        cardholderName: cardholderName,
      );
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, List<Slot>>> getSlots({
    required String clinicId,
    required String date,
  }) async {
    try {
      final result = await datasource.getSlots(clinicId: clinicId, date: date);
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, List<Clinic>>> getDoctorClinic({
    required String doctorId,
  }) async {
    try {
      final result = await datasource.getDoctorClinic(doctorId: doctorId);
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
