import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/appointment/data/datasource/doctor_appo_datasource.dart';
import 'package:chefaa/features/doctor/appointment/data/model/add_prescreption_model/add_prescreption_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/completed_appointment_model/completed_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/doctor_appointment_model/datum.dart';
import 'package:chefaa/features/doctor/appointment/data/model/edit_prescription_model/edit_prescription_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/paied_appointment_model/paied_appointment_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/previous_prescription_model/previous_prescription_model.dart';
import 'package:chefaa/features/doctor/appointment/domain/repository/doctor_appointment_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorAppoRepoImp implements DoctorAppointmentRepo {
  final DoctorAppoDatasource datasource;

  DoctorAppoRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, List<Datum>>> getMyAppo() async {
    try {
      final response = await datasource.getMyAppo();
      final List patient = response['data'];
      return Right(patient.map((e) => Datum.fromMap(e)).toList());
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, AddPrescreptionModel>> addPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    try {
      final response = await datasource.addPrescription(
        appointment: appointment,
        diagnosis: diagnosis,
        medicines: medicines,
        labTests: labTests,
        imaging: imaging,
        nextVisit: nextVisit,
        notes: notes,
      );
      final model = AddPrescreptionModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, CompletedAppointmentModel>> completeAppo({
    required String appoId,
  }) async {
    try {
      final response = await datasource.completeAppo(appoId: appoId);
      final model = CompletedAppointmentModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, EditPrescriptionModel>> editPrescription({
    required String appointment,
    required String diagnosis,
    required List<Map<String, dynamic>> medicines,
    required List<String> labTests,
    required List<String> imaging,
    required String nextVisit,
    required String notes,
  }) async {
    try {
      final response = await datasource.editPrescription(
        appointment: appointment,
        diagnosis: diagnosis,
        medicines: medicines,
        labTests: labTests,
        imaging: imaging,
        nextVisit: nextVisit,
        notes: notes,
      );
      final model = EditPrescriptionModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, PreviousPrescriptionModel>>
  getPreviousPrescription({required String appoId}) async {
    try {
      final response = await datasource.getPreviousPrescription(appoId: appoId);
      final model = PreviousPrescriptionModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, PaiedAppointmentModel>> markAppoPaied({
    required String appoId,
  }) async {
    try {
      final response = await datasource.markAppoPaied(appoId: appoId);
      final model = PaiedAppointmentModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
