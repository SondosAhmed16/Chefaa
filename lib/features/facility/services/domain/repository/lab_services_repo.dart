import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/services/data/model/lab_services_model.dart';
import 'package:chefaa/features/facility/services/data/model/toggle_service_model.dart';
import 'package:dartz/dartz.dart';

abstract class LabServicesRepo {
  Future<Either<ErrorModel, LabServicesModel>> getCenterServices();
  Future<Either<ErrorModel, ToggleServiceModel>> toggleService({
    required String serviceId,
  });
}
