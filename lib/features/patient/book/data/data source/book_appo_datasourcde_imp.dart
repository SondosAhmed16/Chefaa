import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/patient/book/data/data%20source/book_appo_datasource.dart';
import 'package:chefaa/features/patient/book/data/model/book_model.dart';
import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/doctors_clinic.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';
import 'package:chefaa/features/patient/book/data/model/slot_model.dart';

class BookAppoDatasourcdeImp implements BookAppoDatasource {
  final ApiConsumer api;

  BookAppoDatasourcdeImp({required this.api});

  @override
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
  }) async {
    final data = {
      "clinicId": clinicId,
      "date": date,
      "timeChosed": time,
      "isFollowUp": isFollowUp,
      "paymentOption": paymentOption,
    };

    if (paymentOption == "prePay" || paymentOption == "online") {
      if (cardNumber != null) {
        data["cardNumber"] = cardNumber;
      }
      if (expiryMonth != null) {
        data["expiryMonth"] = expiryMonth;
      }
      if (expiryYear != null) {
        data["expiryYear"] = expiryYear;
      }
      if (cvv != null) {
        data["cvv"] = cvv;
      }
      if (cardholderName != null) {
        data["cardholderName"] = cardholderName;
      }
    }
    final response = await api.post(ApiEndpoints.bookAppo, data: data);
    return BookModel.fromMap(response);
  }

  @override
  Future<List<Slot>> getSlots({
    required String clinicId,
    required String date,
  }) async {
    final response = await api.get(
      ApiEndpoints.getSlot(clinicId),
      queryParam: {'date': date},
    );

    final slotModel = SlotModel.fromMap(response as Map<String, dynamic>);
    return slotModel.slots ?? [];
  }

  @override
  Future<List<Clinic>> getDoctorClinic({required String doctorId})async {
    final response = await api.get(ApiEndpoints.getDoctorClinic(doctorId));
    final clinicModel=DoctorsClinic.fromMap(response as Map<String,dynamic>);
    return clinicModel.clinics??[];
  }



  
}
