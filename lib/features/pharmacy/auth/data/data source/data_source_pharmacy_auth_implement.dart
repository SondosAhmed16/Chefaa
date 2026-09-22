import 'dart:io';
import 'package:chefaa/features/pharmacy/auth/data/data%20source/data_source_pharmacy_auth.dart';
import 'package:chefaa/features/pharmacy/auth/data/model/register_pharmacy_model.dart';
import 'package:dio/dio.dart';
import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';

class DataSourcePharmacyAuthImplement implements DataSourcePharmacyAuth {
  final ApiConsumer apiConsumer;

  DataSourcePharmacyAuthImplement({required this.apiConsumer});

  @override
  Future<RegisterPharmacyModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required File membershipFile,
    required String commercialRegisterNumber,
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
          membershipFile.path,
          filename: membershipFile.path.split('/').last,
        ),
      },
      isFormated: true,
    );
    return RegisterPharmacyModel.fromJson(response);
  }
}
