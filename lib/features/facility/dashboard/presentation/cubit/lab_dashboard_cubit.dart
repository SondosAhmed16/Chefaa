import 'package:chefaa/features/facility/dashboard/domain/usecase/get_lab_dashboard_usecase.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabDashboardCubit extends Cubit<LabDashboardState> {
  final GetLabDashboardUsecase getLabDashboardUsecase;

  LabDashboardCubit({required this.getLabDashboardUsecase})
    : super(LabDashboardInitial());

  Future<void> getLabDashboard() async {
    if (!isClosed) emit(LabDashboardLoading());

    final result = await getLabDashboardUsecase.call();

    result.fold(
      (error) => emit(LabDashboardError(error: error)),
      (dashboard) => emit(LabDashboardSuccess(labDashboard: dashboard)),
    );
  }
}
