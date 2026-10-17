import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/dashboard/data/model/lab_dashboard.dart';
import 'package:dartz/dartz.dart';

abstract class LabDashboardRepo {

Future<Either<ErrorModel,LabDashboard>> getLabDashboard();


}