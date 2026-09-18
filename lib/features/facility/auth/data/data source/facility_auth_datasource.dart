import 'dart:io';

import 'package:chefaa/features/facility/auth/data/model/facility_auth_model.dart';

abstract class FacilityAuthDatasource {
  Future<FacilityAuthModel> register({
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
