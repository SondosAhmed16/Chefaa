import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/clinic.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics.dart';

sealed class DoctorHomeState {}

class DoctorHomeInitial extends DoctorHomeState {}

class DoctorClinicsLoading extends DoctorHomeState {}

class DoctorClinicsSuccess extends DoctorHomeState {
  final List<Clinics>? clinics;

  DoctorClinicsSuccess({required this.clinics});
}

class DoctorClinicsError extends DoctorHomeState {
  final ErrorModel error;

  DoctorClinicsError({required this.error});
}

class DoctorClinicLoading extends DoctorHomeState {}

class DoctorClinicSuccess extends DoctorHomeState {
  final Clinic? clinic;

  DoctorClinicSuccess({required this.clinic});
}

class DoctorClinicError extends DoctorHomeState {
  final ErrorModel error;

  DoctorClinicError({required this.error});
}

class DeleteClinicLoading extends DoctorHomeState {}

class DeleteClinicSuccess extends DoctorHomeState {
  final String? message;

  DeleteClinicSuccess({required this.message});
}

class DeleteClinicError extends DoctorHomeState {
  final ErrorModel error;

  DeleteClinicError({required this.error});
}

class UpdateClinicLoading extends DoctorHomeState {}

class UpdateClinicSuccess extends DoctorHomeState {
  final Clinic clinic;

  UpdateClinicSuccess({required this.clinic});
}

class UpdateClinicError extends DoctorHomeState {
  final ErrorModel error;

  UpdateClinicError({required this.error});
}

class AddClinicLoading extends DoctorHomeState {}

class AddClinicSuccess extends DoctorHomeState {
  AddClinicSuccess();
}

class AddClinicError extends DoctorHomeState {
  final ErrorModel error;

  AddClinicError({required this.error});
}
