import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/doctors_clinic.dart';
import 'package:chefaa/features/patient/book/domain/repository/book_appo_repo.dart';
import 'package:dartz/dartz.dart';

class GwtDoctorClinicUsecase {
  final BookAppoRepo repo;

  GwtDoctorClinicUsecase({required this.repo});

  Future<Either<ErrorModel, List<Clinic>>> call({
    required String doctorId,
  }) async {
    return await repo.getDoctorClinic(doctorId: doctorId);
  }
}
