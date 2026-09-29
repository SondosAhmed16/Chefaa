import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/book/data/model/book_model.dart';
import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/doctors_clinic.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';
import 'package:dartz/dartz.dart';

abstract class BookAppoRepo {
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
  });


  Future<Either<ErrorModel,List<Clinic>>> getDoctorClinic({required String doctorId});

  Future<Either<ErrorModel, List<Slot>>> getSlots({
    required String clinicId,
    required String date,
  });
}
