import 'dart:io';
import 'package:chefaa/features/doctor/auth/data/data%20source/data_source_doctor_auth.dart';
import 'package:dio/dio.dart';
import 'package:chefaa/core/API/api_consumer.dart';
import 'package:chefaa/core/API/api_endpoints.dart';
import 'package:chefaa/features/doctor/auth/data/model/register_doctor_model.dart';

class DataSourceDoctorAuthImplement implements DataSourceDoctorAuth {
  final ApiConsumer apiConsumer;

  DataSourceDoctorAuthImplement({required this.apiConsumer});

  @override
  Future<RegisterDoctorModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String specialization,
    required File membershipFile,
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
        "specialization": specialization,
        "membership": await MultipartFile.fromFile(
          membershipFile.path,
          filename: membershipFile.path.split('/').last,
        ),
      },
      isFormated: true,
    );
    return RegisterDoctorModel.fromJson(response);
  }
}
