import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';
import 'package:chefaa/features/patient/lab%20results/domain/repository/lab_result_repo.dart';
import 'package:dartz/dartz.dart';

class GetLabResultsUsecase {


final LabResultRepo repo;

  GetLabResultsUsecase({required this.repo});

  Future<Either<ErrorModel,List<Result>>> call()async{
    return await repo.getLabResults();
  }


}