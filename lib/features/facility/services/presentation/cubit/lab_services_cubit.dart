import 'package:chefaa/features/facility/services/domain/usecase/get_center_services_usecase.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabServicesCubit extends Cubit<LabServicesState> {
  final GetCenterServicesUsecase getCenterServicesUsecase;

  LabServicesCubit({required this.getCenterServicesUsecase})
    : super(LabServicesInitial());

  Future<void> getCenterServices() async {
    if (!isClosed) emit(LabServicesLoading());

    final result = await getCenterServicesUsecase.call();
    result.fold(
      (error) => emit(LabServicesError(error: error)),
      (services) => emit(LabServicesSuccess(services: services)),
    );
  }
}
