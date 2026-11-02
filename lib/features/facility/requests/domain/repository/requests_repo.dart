import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/requests/data/model/add_request_model/add_request_model.dart';
import 'package:dartz/dartz.dart';

abstract class RequestsRepo {

  Future<Either<ErrorModel,AddRequestModel>> addRequest({required Map<String,dynamic> body});
}