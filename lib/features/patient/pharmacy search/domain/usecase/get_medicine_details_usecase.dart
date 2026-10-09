import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/medicine_details_model/medicine_details_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:dartz/dartz.dart';

class GetMedicineDetailsUsecase {
  final PharmacySearchRepo repo;

  GetMedicineDetailsUsecase({required this.repo});

  Future<Either<ErrorModel, MedicineDetailsModel>> call({
    required String medicineId,
  }) async {
    return await repo.getMedicineDetails(medicineId: medicineId);
  }
}
