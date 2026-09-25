import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/search/domain/repository/search_doctor_repo.dart';
import 'package:dartz/dartz.dart';

class GetSearchHistoryUseCase {
  final SearchDoctorRepo repo;
  GetSearchHistoryUseCase(this.repo);

  Future<Either<ErrorModel, List<String>>> call() async {
    return await repo.getSearchHistory();
  }
}
