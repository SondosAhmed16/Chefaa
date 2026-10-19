import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/doctor_profile_model/doctor_profile_model.dart';
import 'package:chefaa/features/doctor/profile/data/model/update_profile_model/update_profile_model.dart';

sealed class DoctorProfileState {}

class DoctorProfileInitial extends DoctorProfileState {}

class DoctorProfileLoading extends DoctorProfileState {}

class DoctorProfileSuccess extends DoctorProfileState {
  final DoctorProfileModel profile;

  DoctorProfileSuccess({required this.profile});
}

class DoctorProfileError extends DoctorProfileState {
  final ErrorModel error;

  DoctorProfileError({required this.error});
}

class UpdateDoctorProfileLoading extends DoctorProfileState {}

class UpdateDoctorProfile extends DoctorProfileState {}

class UpdateDoctorProfileSuccess extends DoctorProfileState {
  final UpdateProfileModel profile;

  UpdateDoctorProfileSuccess({required this.profile});
}

class UpdateDoctorProfileError extends DoctorProfileState {
  final ErrorModel error;

  UpdateDoctorProfileError({required this.error});
}
