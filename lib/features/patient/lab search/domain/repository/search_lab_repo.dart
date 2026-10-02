import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';
import 'package:dartz/dartz.dart';

abstract class SearchLabRepo {
  Future<Either<ErrorModel, List<CenterModel>>> labSearch({
    String? requiredServices,
    bool? homeService,
  });
}
