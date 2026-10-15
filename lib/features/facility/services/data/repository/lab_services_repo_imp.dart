import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/services/data/datasource/lab_services_datasource.dart';
import 'package:chefaa/features/facility/services/data/model/lab_services_model.dart';
import 'package:chefaa/features/facility/services/data/model/toggle_service_model.dart';
import 'package:chefaa/features/facility/services/domain/repository/lab_services_repo.dart';
import 'package:dartz/dartz.dart';

class LabServicesRepoImp implements LabServicesRepo {
  final LabServicesDatasource datasource;

  LabServicesRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, LabServicesModel>> getCenterServices() async {
    try {
      final response = await datasource.getCenterServices();
      final model = LabServicesModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ToggleServiceModel>> toggleService({
    required String serviceId,
  }) async {
    try {
      final response = await datasource.toggleService(serviceId: serviceId);
      final model = ToggleServiceModel.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
