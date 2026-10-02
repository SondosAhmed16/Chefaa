import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';
import 'package:dartz/dartz.dart';

abstract class LabResultRepo {

  Future<Either<ErrorModel,List<Result>>> getLabResults();
}