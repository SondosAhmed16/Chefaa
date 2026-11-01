import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/get_pharmacy_profile.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/settings_updat/settings_updat.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/update_pharmacy_profile/update_pharmacy_profile.dart';
import 'package:dartz/dartz.dart';

abstract class PharmacyProfileRepo {
  Future<Either<ErrorModel, GetPharmacyProfile>> getPharmacyProfile();
  Future<Either<ErrorModel, UpdatePharmacyProfile>> updatePharmacyProfile({
    required Map<String, dynamic> body,
  });
  Future<Either<ErrorModel, SettingsUpdat>> updatePharmacySettings({
    required Map<String, dynamic> body,
  });
}
