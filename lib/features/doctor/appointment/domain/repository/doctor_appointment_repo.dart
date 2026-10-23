import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/add_prescreption_model/add_prescreption_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/completed_appointment_model/completed_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/doctor_appointment_model/datum.dart';
import 'package:chefaa/features/doctor/appointment/data/model/edit_prescription_model/edit_prescription_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/paied_appointment_model/paied_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/previous_prescription_model/previous_prescription_model.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorAppointmentRepo {
  Future<Either<ErrorModel, List<Datum>>> getMyAppo();
  Future<Either<ErrorModel, AddPrescreptionModel>> addPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  });
  Future<Either<ErrorModel, EditPrescriptionModel>> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  });
  Future<Either<ErrorModel, PreviousPrescriptionModel>>
  getPreviousPrescription({required String appoId});
  Future<Either<ErrorModel, CompletedAppointmentModel>> completeAppo({
    required String appoId,
  });
  Future<Either<ErrorModel, PaiedAppointmentModel>> markAppoPaied({
    required String appoId,
  });
}
