import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:chefaa/features/patient/lab%20search/domain/repository/search_lab_repo.dart';
import 'package:dartz/dartz.dart';

class LabSearchUsecase {
  final SearchLabRepo repo;

  LabSearchUsecase({required this.repo});

  Future<Either<ErrorModel, List<CenterModel>>> call({
    String? requiredServices,
    bool? homeService,
  }) async {
    return await repo.labSearch(
      requiredServices: requiredServices,
      homeService: homeService,
    );
  }
}
