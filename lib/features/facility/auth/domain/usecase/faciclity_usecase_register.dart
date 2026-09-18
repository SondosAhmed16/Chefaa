import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/auth/domain/entity/facility_register_entity.dart';
import 'package:chefaa/features/facility/auth/domain/repository/facility_register_repo.dart';
import 'package:dartz/dartz.dart';

class FaciclityUsecaseRegister {
  final FacilityRegisterRepo facilityRegisterRepo;

  FaciclityUsecaseRegister({required this.facilityRegisterRepo});

  Future<Either<ErrorModel, FacilityRegisterEntity>> call({
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
    return await facilityRegisterRepo.register(
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
  }
}
