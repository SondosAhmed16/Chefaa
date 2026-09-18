import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/auth/domain/entities/register_doctor_response_entity.dart';
import 'package:chefaa/features/doctor/auth/domain/repository/register_doctor_reopsitory.dart';
import 'package:dartz/dartz.dart';

class RegisterDoctorUsecase {
  final RegisterDoctorReopsitory registerDoctorReopsitory;

  RegisterDoctorUsecase({required this.registerDoctorReopsitory});

  Future<Either<ErrorModel, RegisterDoctorResponseEntity>> call({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required final String specialization,
    required final File membershipFile,
  }) async {
    return await registerDoctorReopsitory.register(
      name: name,
      userName: userName,
      phone: phone,
      email: email,
      password: password,
      role: role,
      specialization: specialization,
      membershipFile: membershipFile,
    );
  }
}
