import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/home/domain/entity/appointment_entity.dart';
import 'package:chefaa/features/patient/home/domain/repository/home_patient_repo.dart';
import 'package:dartz/dartz.dart';

class GetUpcomingAppointmentUsecase {

  final HomePatientRepo repo;

  GetUpcomingAppointmentUsecase({required this.repo});

  Future<Either<ErrorModel,List<AppointmentEntity>>> call()async{
   return await repo.getUpcommingApp();
  }


}