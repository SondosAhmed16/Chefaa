import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/datasource/ai_lab_report_datasource.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/domain/repository/lab_report_repo.dart';
import 'package:dartz/dartz.dart';

class LabReportRepoImp implements LabReportRepo {
  final AiLabReportDatasource datasource;

  LabReportRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, Data>> analyzeReport({
    required File labReport,
  }) async {
    try {
      final response = await datasource.analyzeReport(labReport: labReport);
      return Right(response);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
