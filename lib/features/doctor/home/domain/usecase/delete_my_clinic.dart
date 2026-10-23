import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/delete_clinic_model.dart';
import 'package:chefaa/features/doctor/home/domain/repository/doctor_home_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteMyClinic {
  final DoctorHomeRepo repo;

  DeleteMyClinic({required this.repo});

  Future<Either<ErrorModel, DeleteClinicModel>> call({
    required String clinicId,
  }) {
    return repo.deleteMyClinic(clinicId: clinicId);
  }
}
