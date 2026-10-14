import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/profile/data/model/lab_profile_response.dart';

sealed class LabProfileState {}

class LabProfileInitial extends LabProfileState {}

class LabProfileLoading extends LabProfileState {}

class LabProfileSuccess extends LabProfileState {
  final LabProfileResponse response;

  LabProfileSuccess({required this.response});
}

class LabProfileError extends LabProfileState {
  final ErrorModel error;

  LabProfileError({required this.error});
}

class LabProfileUpdating extends LabProfileState {}

class LabProfileUpdateSuccess extends LabProfileState {
  final LabProfileResponse response;
  final String message;

  LabProfileUpdateSuccess({required this.response, required this.message});
}

class LabProfileUpdateError extends LabProfileState {
  final ErrorModel error;

  LabProfileUpdateError({required this.error});
}
