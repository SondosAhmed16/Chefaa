import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/lab%20results/data/datasource/lab_result_datasource.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';
import 'package:chefaa/features/patient/lab%20results/domain/repository/lab_result_repo.dart';
import 'package:dartz/dartz.dart';

class LabResultRepoImp implements LabResultRepo {
  final LabResultDatasource datasource;

  LabResultRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, List<Result>>> getLabResults() async {
    try {
      final response = await datasource.getLabResults();
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
