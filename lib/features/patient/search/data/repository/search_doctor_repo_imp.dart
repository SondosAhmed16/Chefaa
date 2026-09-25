import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/search/data/data%20source/local/search_doctor_local_ds.dart';
import 'package:chefaa/features/patient/search/data/data%20source/remote/search_doctor_remote_ds.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';
import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class SearchDoctorRepoImp implements SearchDoctorRepo {
  final SearchDoctorRemoteDs remoteDs;
  final SearchDoctorLocalDs localDs;

  SearchDoctorRepoImp({required this.remoteDs, required this.localDs});

  @override
  Future<Either<ErrorModel, List<DoctorEntity>>> searchDoctors({
    String? searchText,
    String? specialization,
    String? gender,
    String? location,
  }) async {
    try {
      if (searchText != null && searchText.trim().isNotEmpty) {
        await localDs.saveSearchQuery(searchText.trim());
      }

      final models = await remoteDs.searchDoctors(
        searchText: searchText,
        specialization: specialization,
        gender: gender,
        location: location,
      );

      final List<DoctorEntity> entities = models
          .map(
           (model) => DoctorEntity(
              id: model.id ?? '',
              name: model.name ?? '',
              specialization: model.specialization ?? '',
              profilePicture: model.image, 
              gender: model.gender,
              bio: model.about,
            ),
          )
          .toList();

      return Right(entities);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, List<String>>> getSearchHistory() async {
    try {
      final history = await localDs.getSearchHistory();
      return Right(history);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, void>> saveSearchQuery(String query) async {
    try {
      await localDs.saveSearchQuery(query);
      return const Right(null);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, void>> clearSearchHistory() async {
    try {
      await localDs.clearSearchHistory();
      return const Right(null);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, void>> deleteSearchQuery(String query) async {
    try {
      await localDs.deleteSearchQuery(query);
      return const Right(null);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
