import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/datasource/pharmacy_search_datasource.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_medicienes_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_search_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/domain/repository/pharmacy_search_repo.dart';
import 'package:dartz/dartz.dart';

class PharmacySearchRepoImp implements PharmacySearchRepo {
  final PharmacySearchDatasource datasource;

  PharmacySearchRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, PharmacySearchModel>> pharmacySearch({
    required String searchQuery,
  }) async {
    try {
      final response = await datasource.searchPharmacy(
        searchQuery: searchQuery,
      );
      final model = PharmacySearchModel.fromMap(
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
  Future<Either<ErrorModel, PharmacyProfileModel>> getPharmacyProfile({
    required String pharmacyId,
  }) async {
    try {
      final response = await datasource.getPharmacyProfile(
        pharmacyId: pharmacyId,
      );
      final model = PharmacyProfileModel.fromMap(
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
  Future<Either<ErrorModel, PharmacyMedicienesModel>> getPharmacyMedicens({
    required String pharmacyId,
  }) async {
    try {
      final response = await datasource.getPharmacyMedicines(
        pharmacyId: pharmacyId,
      );
      final model = PharmacyMedicienesModel.fromMap(
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
