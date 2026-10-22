import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics_model.dart';
import 'package:chefaa/features/doctor/home/data/model/delete_clinic_model.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorHomeRepo {
  Future<Either<ErrorModel, ClinicsModel>> getClinics({
    required String doctorId,
  });
  Future<Either<ErrorModel, ClinicModel>> getMyClinic({
    required String clinicId,
  });
  Future<Either<ErrorModel, DeleteClinicModel>> deleteMyClinic({
    required String clinicId,
  });
  Future<Either<ErrorModel, ClinicModel>> updateClinics({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });

  Future<Either<ErrorModel, ClinicModel>> addClinic({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  });
}
