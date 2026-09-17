import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/auth/domain/entities/register_patient_response_entity.dart';
import 'package:chefaa/features/patient/auth/domain/repository/register_patient_reopsitory.dart';
import 'package:dartz/dartz.dart';

class RegisterPatientUsecase {
  final RegisterPatientReopsitory registerPatientReopsitory;

  RegisterPatientUsecase({required this.registerPatientReopsitory});

  Future<Either<ErrorModel, RegisterPatientResponseEntity>> call({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
  }) async {
    return await registerPatientReopsitory.register(
      name: name,
      userName: userName,
      phone: phone,
      email: email,
      password: password,
      role: role,
    );
  }
}
