import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/dashboard/data/datasource/lab_dashboard_datasource.dart';
import 'package:chefaa/features/facility/dashboard/data/model/lab_dashboard.dart';
import 'package:chefaa/features/facility/dashboard/domain/repository/lab_dashboard_repo.dart';
import 'package:dartz/dartz.dart';

class LabDashboardRepoImp implements LabDashboardRepo {
  final LabDashboardDatasource datasource;

  LabDashboardRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, LabDashboard>> getLabDashboard() async {
    try {
      final response = await datasource.getLabDashboard();
      final model = LabDashboard.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
