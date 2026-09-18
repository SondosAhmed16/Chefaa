import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/auth/domain/entities/register_doctor_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterDoctorReopsitory {
  Future<Either<ErrorModel, RegisterDoctorResponseEntity>> register({
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
