import 'dart:io';

import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/facility/auth/data/data%20source/facility_auth_datasource.dart';
import 'package:chefaa/features/facility/auth/data/model/facility_auth_model.dart';
import 'package:dio/dio.dart';

class FacilituAuthDatasourceImp implements FacilityAuthDatasource {
  final ApiConsumer apiConsumer;

  FacilituAuthDatasourceImp({required this.apiConsumer});

  @override
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
  }) async {
    final response = await apiConsumer.post(
      ApiEndpoints.register,
      data: {
        "name": name,
        "username": userName,
        "email": email,
        "password": password,
        "phoneNumber": phone,
        "role": role,
        "commercialRegisterNumber": commercialRegisterNumber,
        "medicalLicence": await MultipartFile.fromFile(
          medicalLicencePdf.path,
          filename: medicalLicencePdf.path.split('/').last,
        ),
        "facilityType": facilityType,
        "medicalDirectorName": medicalDirectorName,
        "directorProfessionalId": directorProfessionalId,
      },
      isFormated: true,
    );
    return FacilityAuthModel.fromJson(response);
  }
}
