import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/medication/data/data%20source/medication_datasourcse.dart';
import 'package:chefaa/features/patient/medication/data/model/confirm_medication.dart';
import 'package:chefaa/features/patient/medication/data/model/medication_list.dart';
import 'package:chefaa/features/patient/medication/data/model/medication_response.dart';
import 'package:chefaa/features/patient/medication/data/model/medications.dart';
import 'package:chefaa/features/patient/medication/domain/repository/medication_repo.dart';
import 'package:dio/dio.dart';

class MedicationRepoImp implements MedicationRepo {
  final MedicationDataSource dataSource;

  MedicationRepoImp({required this.dataSource});

  @override
  Future<MedicationResponse> addMedication({
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async {
    try {
      var response = await dataSource.addMedication(
        name: name,
        dosage: dosage,
        form: form,
        timesPerDay: timesPerDay,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
      );
      return MedicationResponse.fromJson(response.data);
    } on Exceptions catch (e) {
      throw e.errorModel;
    } catch (e) {
      throw ErrorModel(message: e.toString());
    }
  }

  @override
  Future<ConfirmMedication> confirmMedication(String medicationId) async {
    try {
      var response = await dataSource.confirmMedication(medicationId);
      return ConfirmMedication.fromJson(response.data);
    } on Exceptions catch (e) {
      throw e.errorModel;
    } catch (e) {
      throw ErrorModel(message: e.toString());
    }
  }

  @override
  Future<MedicationResponse> deleteMedication(String medicationId) async {
    try {
      var response = await dataSource.deleteMedication(medicationId);
      return MedicationResponse.fromJson(response.data);
    } on Exceptions catch (e) {
      throw e.errorModel;
    } catch (e) {
      throw ErrorModel(message: e.toString());
    }
  }

@override
  Future<MedicationList> getMedicationList() async {
    try {
      var response = await dataSource.getMedicationList();
      
      // هنا response سيكون إما List مباشرة أو Map
      if (response is List) {
        List<Medications> medsList = response
            .map((e) => Medications.fromJson(e))
            .toList();
            
        return MedicationList(medications: medsList);
      }
      
      return MedicationList.fromJson(response);
    } on Exceptions catch (e) {
      throw e.errorModel;
    } catch (e) {
      throw ErrorModel(message: e.toString());
    }
  }

  @override
  Future<MedicationResponse> updateMedication({
    required String medicationId,
    required String name,
    required String dosage,
    required String form,
    required int timesPerDay,
    required List<String> schedule,
    required String startDate,
    required String endDate,
    required bool isActive,
  }) async {
    try {
      var response = await dataSource.updateMedication(
        medicationId: medicationId,
        name: name,
        dosage: dosage,
        form: form,
        timesPerDay: timesPerDay,
        schedule: schedule,
        startDate: startDate,
        endDate: endDate,
        isActive: isActive,
      );
      return MedicationResponse.fromJson(response.data);
    } on Exceptions catch (e) {
      throw e.errorModel;
    } catch (e) {
      throw ErrorModel(message: e.toString());
    }
  }
}
