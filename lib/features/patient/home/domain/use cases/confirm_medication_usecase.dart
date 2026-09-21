import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/home/domain/repository/home_patient_repo.dart';
import 'package:dartz/dartz.dart';

class ConfirmMedicationUsecase {
  final HomePatientRepo repo;

  ConfirmMedicationUsecase({required this.repo});

  Future<Either<ErrorModel, void>> call(String medicationId) async {
    return await repo.confirmMedicationTaken(medicationId);
  }
}
