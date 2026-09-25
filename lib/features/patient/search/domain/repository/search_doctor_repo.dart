import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchDoctorRepo {
  Future<Either<ErrorModel, List<DoctorEntity>>> searchDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  });

  Future<Either<ErrorModel, List<String>>> getSearchHistory();
  Future<Either<ErrorModel, void>> saveSearchQuery(String query);
  Future<Either<ErrorModel, void>> clearSearchHistory();
  Future<Either<ErrorModel, void>> deleteSearchQuery(String query);
}