import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/dashboard/data/model/lab_dashboard.dart';
import 'package:chefaa/features/facility/dashboard/domain/repository/lab_dashboard_repo.dart';
import 'package:dartz/dartz.dart';

class GetLabDashboardUsecase {

final LabDashboardRepo repo;

  GetLabDashboardUsecase({required this.repo});

Future<Either<ErrorModel,LabDashboard>> call()async{
  return await repo.getLabDashboard();
}
}