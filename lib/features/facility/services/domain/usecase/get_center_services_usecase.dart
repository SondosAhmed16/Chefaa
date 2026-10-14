import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/services/data/model/lab_services_model.dart';
import 'package:chefaa/features/facility/services/domain/repository/lab_services_repo.dart';
import 'package:dartz/dartz.dart';

class GetCenterServicesUsecase {


final LabServicesRepo repo;

  GetCenterServicesUsecase({required this.repo});

  Future<Either<ErrorModel,LabServicesModel>> call()async{
    return await repo.getCenterServices();
  }

}