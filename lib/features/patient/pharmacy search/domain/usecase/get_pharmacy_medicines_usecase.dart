import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_medicienes_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:dartz/dartz.dart';

class GetPharmacyMedicinesUsecase {
  final PharmacySearchRepo repo;

  GetPharmacyMedicinesUsecase({required this.repo});

  Future<Either<ErrorModel, PharmacyMedicienesModel>> call({
    required String pharmacyId,
  }) async {
    return await repo.getPharmacyMedicens(pharmacyId: pharmacyId);
  }
}
