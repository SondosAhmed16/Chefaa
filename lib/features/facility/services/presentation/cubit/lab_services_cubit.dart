import 'package:chefaa/features/facility/services/domain/repository/lab_services_repo.dart';
import 'package:chefaa/features/facility/services/domain/usecase/get_center_services_usecase.dart';
import 'package:chefaa/features/facility/services/domain/usecase/toggle_service_usecase.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabServicesCubit extends Cubit<LabServicesState> {
  final GetCenterServicesUsecase getCenterServicesUsecase;
  final ToggleServiceUsecase toggleServiceUsecase;
  final LabServicesRepo repo;

  LabServicesCubit({
    required this.getCenterServicesUsecase,
    required this.toggleServiceUsecase,
    required this.repo,
  }) : super(LabServicesInitial());

  Future<void> getCenterServices() async {
    if (!isClosed) emit(LabServicesLoading());

    final result = await getCenterServicesUsecase.call();
    result.fold(
      (error) => emit(LabServicesError(error: error)),
      (services) => emit(LabServicesSuccess(services: services)),
    );
  }

  Future<void> toggleService({required String serviceId}) async {
    if (!isClosed) emit(LabServicesToggleLoading());

    final result = await toggleServiceUsecase.call(serviceId: serviceId);
    result.fold(
      (error) => emit(LabServicesToggleError(error: error)),
      (service) => emit(LabServicesToggleSuccess(service: service)),
    );
  }

  Future<void> AddService({required Map<String, dynamic> body}) async {
    if (!isClosed) emit(LabServicesAddLoading());

    final result = await repo.addService(body: body);

    result.fold((error) => emit(LabServicesAddError(error: error)), (
      service,
    ) async {
      emit(LabServicesAddSuccess(service: service));
      await getCenterServices();
    });
  }
}
