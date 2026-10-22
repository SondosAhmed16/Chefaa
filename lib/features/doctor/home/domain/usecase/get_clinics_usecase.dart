import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics_model.dart';
import 'package:chefaa/features/doctor/home/domain/repository/doctor_home_repo.dart';
import 'package:dartz/dartz.dart';

class GetClinicsUsecase {
  final DoctorHomeRepo repo;

  GetClinicsUsecase({required this.repo});

  Future<Either<ErrorModel, ClinicsModel>> call({required String doctorId}) {
    return repo.getClinics(doctorId: doctorId);
  }
}
