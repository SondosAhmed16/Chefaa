import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/requests/data/datasource/requests_datasource.dart';
import 'package:chefaa/features/facility/requests/data/model/add_request_model/add_request_model.dart';
import 'package:chefaa/features/facility/requests/data/model/upload_result_model/upload_result_model.dart';
import 'package:chefaa/features/facility/requests/domain/repository/requests_repo.dart';
import 'package:dartz/dartz.dart';

class RequestsRepoImp implements RequestsRepo {
  final RequestsDatasource datasource;

  RequestsRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, AddRequestModel>> addRequest({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.addRequest(body: body);
      final model = AddRequestModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, UploadResultModel>> uploadResult({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.uploadResult(body: body);
      final model = UploadResultModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
