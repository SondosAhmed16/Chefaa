import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/dashboard/data/model/lab_dashboard.dart';

sealed class LabDashboardState {}

class LabDashboardInitial extends LabDashboardState {}

class LabDashboardLoading extends LabDashboardState {}

class LabDashboardSuccess extends LabDashboardState {
  final LabDashboard labDashboard;

  LabDashboardSuccess({required this.labDashboard});
}

class LabDashboardError extends LabDashboardState {
  final ErrorModel error;

  LabDashboardError({required this.error});
}
