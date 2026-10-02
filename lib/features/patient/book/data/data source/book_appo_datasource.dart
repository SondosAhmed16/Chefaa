import 'package:chefaa/features/patient/book/data/model/book_model.dart';
import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';

abstract class BookAppoDatasource {
  Future<BookModel> bookAppo({
    required String clinicId,
    required String date,
    required String time,
    required bool isFollowUp,
    required String paymentOption,
    String? cardNumber,
    String? expiryMonth,
    String? expiryYear,
    String? cvv,
    String? cardholderName,
  });

  Future<List<Slot>> getSlots({required String clinicId, required String date});

  Future<List<Clinic>> getDoctorClinic({required String doctorId});
}
