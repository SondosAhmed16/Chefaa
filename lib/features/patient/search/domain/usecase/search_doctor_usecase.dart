import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';
import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class SearchDoctorUsecase {
  final SearchDoctorRepo repo;

  SearchDoctorUsecase({required this.repo});

  Future<Either<ErrorModel, List<DoctorEntity>>> call({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    return await repo.searchDoctors(
      searchText: searchText,
      specialization: specialization,
      gender: gender,
      location: location,
    );
  }
}
