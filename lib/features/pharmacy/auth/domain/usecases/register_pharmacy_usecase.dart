import 'dart:io';

import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/auth/domain/entities/register_pharmacy_response_entity.dart';
import 'package:chefaa/features/pharmacy/auth/domain/repository/register_pharmacy_reopsitory.dart';

import 'package:dartz/dartz.dart';

class RegisterPharmacyUsecase {
  final RegisterPharmacyReopsitory registerPharmacyReopsitory;

  RegisterPharmacyUsecase({required this.registerPharmacyReopsitory});


  Future<Either<ErrorModel, RegisterPharmacyResponseEntity>> call({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required String commercialRegisterNumber,
    required final File membershipFile,
  }) async {
    return await registerPharmacyReopsitory.register(
      name: name,
      userName: userName,
      phone: phone,
      email: email,
      password: password,
      role: role,
      membershipFile: membershipFile, 
      commercialRegisterNumber: commercialRegisterNumber,
    );
  }
}
