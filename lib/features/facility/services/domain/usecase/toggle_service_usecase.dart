import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/services/data/model/toggle_service_model.dart';
import 'package:chefaa/features/facility/services/domain/repository/lab_services_repo.dart';
import 'package:dartz/dartz.dart';

class ToggleServiceUsecase {
  final LabServicesRepo repo;

  ToggleServiceUsecase({required this.repo});
  Future<Either<ErrorModel, ToggleServiceModel>> call({
    required String serviceId,
  }) async {
    return await repo.toggleService(serviceId: serviceId);
  }
}
