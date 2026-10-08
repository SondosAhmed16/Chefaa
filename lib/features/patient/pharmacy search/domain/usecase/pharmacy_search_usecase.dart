import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_search_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:dartz/dartz.dart';

class PharmacySearchUsecase {
  final PharmacySearchRepo repo;

  PharmacySearchUsecase({required this.repo});

  Future<Either<ErrorModel, PharmacySearchModel>> call({
    required String searchQuery,
  }) async {
    return await repo.pharmacySearch(searchQuery: searchQuery);
  }
}
