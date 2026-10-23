import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/appointment/data/model/doctor_appointment_model/datum.dart';
import 'package:chefaa/features/doctor/appointment/domain/repository/doctor_appointment_repo.dart';
import 'package:dartz/dartz.dart';

class GetMuAppoRepo {
  final DoctorAppointmentRepo repo;

  GetMuAppoRepo({required this.repo});

  Future<Either<ErrorModel, List<Datum>>> call() {
    return repo.getMyAppo();
  }
}
