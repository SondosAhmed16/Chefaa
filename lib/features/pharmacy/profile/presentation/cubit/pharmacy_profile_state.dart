import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/get_pharmacy_profile.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/settings_updat/settings_updat.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/update_pharmacy_profile/update_pharmacy_profile.dart';

sealed class PharmacyProfileState {}

class PharmacyProfileInitial extends PharmacyProfileState {}

class PharmacyProfileLoading extends PharmacyProfileState {}

class PharmacyProfileSuccess extends PharmacyProfileState {
  final GetPharmacyProfile profile;

  PharmacyProfileSuccess({required this.profile});
}

class PharmacyProfileError extends PharmacyProfileState {
  final ErrorModel error;

  PharmacyProfileError({required this.error});
}

class UpdatePharmacyProfileLoading extends PharmacyProfileState {}

class UpdatePharmacyProfileSuccess extends PharmacyProfileState {
  final UpdatePharmacyProfile profile;

  UpdatePharmacyProfileSuccess({required this.profile});
}

class UpdatePharmacyProfileError extends PharmacyProfileState {
  final ErrorModel error;

  UpdatePharmacyProfileError({required this.error});
}

class UpdatePharmacySettingsLoading extends PharmacyProfileState {}

class UpdatePharmacySettingsSuccess extends PharmacyProfileState {
  final SettingsUpdat settingsUpdat;

  UpdatePharmacySettingsSuccess({required this.settingsUpdat});
}

class UpdatePharmacySettingsError extends PharmacyProfileState {
  final ErrorModel error;

  UpdatePharmacySettingsError({required this.error});
}
