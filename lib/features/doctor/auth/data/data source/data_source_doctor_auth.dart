import 'dart:io';
import 'package:chefaa/features/doctor/auth/data/model/register_doctor_model.dart';

abstract class DataSourceDoctorAuth {
  Future<RegisterDoctorModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String specialization,
    required File membershipFile,
  });
}
