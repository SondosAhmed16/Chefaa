import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:dartz/dartz.dart';

class GetPharmacyProfileUsecase {
  final PharmacySearchRepo repo;

  GetPharmacyProfileUsecase({required this.repo});
  Future<Either<ErrorModel, PharmacyProfileModel>> call({
    required String pharmacyId,
  }) async {
    return await repo.getPharmacyProfile(pharmacyId: pharmacyId);
  }
}
