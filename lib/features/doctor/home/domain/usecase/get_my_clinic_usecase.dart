import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic_model.dart';
import 'package:chefaa/features/doctor/home/domain/repository/doctor_home_repo.dart';
import 'package:dartz/dartz.dart';

class GetMyClinicUsecase {
  final DoctorHomeRepo repo;

  GetMyClinicUsecase({required this.repo});

  Future<Either<ErrorModel, ClinicModel>> call({required String clinicId}) {
    return repo.getMyClinic(clinicId: clinicId);
  }
}
