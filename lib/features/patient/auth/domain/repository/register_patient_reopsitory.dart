import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/auth/domain/entities/register_patient_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RegisterPatientReopsitory {
  Future<Either<ErrorModel, RegisterPatientResponseEntity>> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  });
}
