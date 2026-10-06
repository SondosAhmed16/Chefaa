import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';
import 'package:dartz/dartz.dart';

abstract class LabReportRepo {
  Future<Either<ErrorModel, Data>> analyzeReport({required File labReport});
}
