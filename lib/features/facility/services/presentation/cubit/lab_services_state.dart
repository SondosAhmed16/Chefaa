import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/services/data/model/lab_services_model.dart';
import 'package:chefaa/features/facility/services/data/model/toggle_service_model.dart';

sealed class LabServicesState {}

class LabServicesInitial extends LabServicesState {}

class LabServicesLoading extends LabServicesState {}

class LabServicesSuccess extends LabServicesState {
  final LabServicesModel services;

  LabServicesSuccess({required this.services});
}

class LabServicesError extends LabServicesState {
  final ErrorModel error;

  LabServicesError({required this.error});
}

class LabServicesToggleLoading extends LabServicesState {}

class LabServicesToggleSuccess extends LabServicesState {
  final ToggleServiceModel service;

  LabServicesToggleSuccess({required this.service});
}

class LabServicesToggleError extends LabServicesState {
  final ErrorModel error;

  LabServicesToggleError({required this.error});
}
