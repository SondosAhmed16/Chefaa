import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/auth/domain/entity/facility_register_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FacilityRegisterRepo {
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
  });
}
