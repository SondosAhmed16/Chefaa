import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/core/error%20handle/exceptions.dart';
import 'package:chefaa/features/pharmacy/profile/data/datasource/pharmacy_profille_datasource.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/get_pharmacy_profile.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/settings_updat/settings_updat.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/update_pharmacy_profile/update_pharmacy_profile.dart';
import 'package:chefaa/features/pharmacy/profile/domain/repository/pharmacy_profile_repo.dart';
import 'package:dartz/dartz.dart';

class PharmacyProfileRepoImp implements PharmacyProfileRepo {
  final PharmacyProfilleDatasource datasource;

  PharmacyProfileRepoImp({required this.datasource});

  @override
  Future<Either<ErrorModel, GetPharmacyProfile>> getPharmacyProfile() async {
    try {
      final response = await datasource.getPharmacyProfile();
      final model = GetPharmacyProfile.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, UpdatePharmacyProfile>> updatePharmacyProfile({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.updatePharmacyProfile(body: body);
      final model = UpdatePharmacyProfile.fromMap(
        response as Map<String, dynamic>,
      );
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<ErrorModel, SettingsUpdat>> updatePharmacySettings({
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await datasource.updatePharmacySettings(body: body);
      final model = SettingsUpdat.fromMap(response as Map<String, dynamic>);
      return Right(model);
    } on Exceptions catch (e) {
      return Left(e.errorModel);
    } catch (e) {
      return Left(ErrorModel(message: e.toString()));
    }
  }
}
