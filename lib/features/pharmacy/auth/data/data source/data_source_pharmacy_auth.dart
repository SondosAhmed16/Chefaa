import 'dart:io';

import 'package:chefaa/features/pharmacy/auth/data/model/register_pharmacy_model.dart';

abstract class DataSourcePharmacyAuth {
  Future<RegisterPharmacyModel> register({
    required String name,
    required String userName,
    required String phone,
    required String email,
    required String password,
    required String role,
    required File membershipFile,
    required String commercialRegisterNumber,
  });
}
