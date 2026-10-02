import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/lab%20search/data/datasource/lab_search_datasource.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:chefaa/features/patient/lab%20search/domain/repository/search_lab_repo.dart';
import 'package:dartz/dartz.dart';

class SearchLabRepoImp implements SearchLabRepo {
  final LabSearchDatasource datasource;

  SearchLabRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, List<CenterModel>>> labSearch({
    String? requiredServices,
    bool? homeService,
  }) async {
    try {
      final result = await datasource.searchLab(
        requiredServices: requiredServices,
        homeService: homeService,
      );
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
