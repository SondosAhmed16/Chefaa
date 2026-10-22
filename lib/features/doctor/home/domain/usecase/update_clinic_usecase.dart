import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic_model.dart';
import 'package:chefaa/features/doctor/home/domain/repository/doctor_home_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateClinicUsecase {
  final DoctorHomeRepo repo;

  UpdateClinicUsecase({required this.repo});

  Future<Either<ErrorModel, ClinicModel>> call({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) {
    return repo.updateClinics(
      clinicID: clinicID,
      name: name,
      address: address,
      city: city,
      price: price,
      operatingLicense: operatingLicense,
      location: location,
      schedule: schedule,
    );
  }
}
