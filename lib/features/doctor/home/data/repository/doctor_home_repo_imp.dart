import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/doctor/home/data/datasource/doctor_home_datasource.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics_model.dart';
import 'package:chefaa/features/doctor/home/data/model/delete_clinic_model.dart';
import 'package:chefaa/features/doctor/home/domain/repository/doctor_home_repo.dart';
import 'package:dartz/dartz.dart';

class DoctorHomeRepoImp implements DoctorHomeRepo {
  final DoctorHomeDatasource datasource;

  DoctorHomeRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, ClinicsModel>> getClinics({
    required String doctorId,
  }) async {
    try {
      final response = await datasource.getDoctorClinics(doctorId: doctorId);
      final model = ClinicsModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ClinicModel>> getMyClinic({
    required String clinicId,
  }) async {
    try {
      final response = await datasource.getMyClinic(clinicId: clinicId);
      final model = ClinicModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, DeleteClinicModel>> deleteMyClinic({
    required String clinicId,
  }) async {
    try {
      final response = await datasource.deleteMyClinic(clinicId: clinicId);
      final model = DeleteClinicModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ClinicModel>> updateClinics({
    required String clinicID,
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) async {
    try {
      final response = await datasource.updateClinic(
        clinicID: clinicID,
        name: name,
        address: address,
        city: city,
        price: price,
        operatingLicense: operatingLicense,
        location: location,
        schedule: schedule,
      );
      final model = ClinicModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, ClinicModel>> addClinic({
    required String? name,
    required String? address,
    required String? city,
    required num? price,
    required String? operatingLicense,
    required Map<String, dynamic>? location,
    required Map<String, dynamic>? schedule,
  }) async {
    try {
      final response = await datasource.addClinic(
        name: name,
        address: address,
        city: city,
        price: price,
        operatingLicense: operatingLicense,
        location: location,
        schedule: schedule,
      );
      final model = ClinicModel.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
