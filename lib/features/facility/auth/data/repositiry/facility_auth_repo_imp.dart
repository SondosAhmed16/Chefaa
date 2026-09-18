import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/facility/auth/data/data%20source/facility_auth_datasource.dart';
import 'package:chefaa/features/facility/auth/domain/entity/facility_register_entity.dart';
import 'package:chefaa/features/facility/auth/domain/repository/facility_register_repo.dart';
import 'package:dartz/dartz.dart';

class FacilityAuthRepoImp implements FacilityRegisterRepo {
  final FacilityAuthDatasource facilityAuthDatasource;

  FacilityAuthRepoImp({required this.facilityAuthDatasource});

  @override
  Future<Either<ErrorModel, FacilityRegisterEntity>> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String commercialRegisterNumber,
    required File medicalLicencePdf,
    required String facilityType,
    required String medicalDirectorName,
    required String directorProfessionalId,
  }) async {
    try {
      final result = await facilityAuthDatasource.register(
        name: name,
        userName: userName,
        phone: phone,
        email: email,
        password: password,
        role: role,
        commercialRegisterNumber: commercialRegisterNumber,
        medicalLicencePdf: medicalLicencePdf,
        facilityType: facilityType,
        medicalDirectorName: medicalDirectorName,
        directorProfessionalId: directorProfessionalId,
      );
      return Right(result);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
