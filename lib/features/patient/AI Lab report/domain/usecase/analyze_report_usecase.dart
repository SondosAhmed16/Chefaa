import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/domain/repository/lab_report_repo.dart';
import 'package:dartz/dartz.dart';

class AnalyzeReportUsecase {
  final LabReportRepo repo;

  AnalyzeReportUsecase({required this.repo});

  Future<Either<ErrorModel, Data>> call({required File labReport}) async {
    return await repo.analyzeReport(labReport: labReport);
  }
}
