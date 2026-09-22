import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/profile/domain/entity/profile_patient_entity.dart';

sealed class ProfilePatientState {}

class PatientProfileInitialState extends ProfilePatientState {}

class GetProfileLoadingState extends ProfilePatientState {}

class GetProfileSuccessState extends ProfilePatientState {
  final ProfilePatientEntity profile;
  GetProfileSuccessState({required this.profile});
}

class GetProfileErrorState extends ProfilePatientState {
  final ErrorModel error;
  GetProfileErrorState({required this.error});
}

class UpdateBasicInfoLoadingState extends ProfilePatientState {}

class UpdateBasicInfoSuccessState extends ProfilePatientState {
  final ProfilePatientEntity profile;
  UpdateBasicInfoSuccessState({required this.profile});
}

class UpdateBasicInfoErrorState extends ProfilePatientState {
  final ErrorModel error;
  UpdateBasicInfoErrorState({required this.error});
}

class UpdateMedInfoLoadingState extends ProfilePatientState {}

class UpdateMedInfoSuccessState extends ProfilePatientState {
  final ProfilePatientEntity profile;
  UpdateMedInfoSuccessState({required this.profile});
}

class UpdateMedInfoErrorState extends ProfilePatientState {
  final ErrorModel error;
  UpdateMedInfoErrorState({required this.error});
}

class GenderChangedState extends ProfilePatientState {}

class BloodTypeChangedState extends ProfilePatientState {}
