import 'package:chefaa/features/patient/medication/data/model/confirm_medication.dart';
import 'package:chefaa/features/patient/medication/data/model/medication_list.dart';
import 'package:chefaa/features/patient/medication/data/model/medication_response.dart';

sealed class MedicationState {}

final class MedicationInitialState extends MedicationState {}

final class MedicationAdditionLoadingState extends MedicationState {}

final class MedicationAdditionSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;

  MedicationAdditionSuccessState({required this.medicationResponse});
}

final class MedicationAdditionErrorState extends MedicationState {
  final String errorMessage;

  MedicationAdditionErrorState({required this.errorMessage});
}

final class MedicationDeleteLoadingState extends MedicationState {}

final class MedicationDeleteSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;

  MedicationDeleteSuccessState({required this.medicationResponse});
}

final class MedicationDeleteErrorState extends MedicationState {
  final String errorMessage;

  MedicationDeleteErrorState({required this.errorMessage});
}

final class MedicationConfirmLoadingState extends MedicationState {}

final class MedicationConfirmSuccessState extends MedicationState {
  final ConfirmMedication confirmMedication;

  MedicationConfirmSuccessState({required this.confirmMedication});
}

final class MedicationConfirmErrorState extends MedicationState {
  final String errorMessage;

  MedicationConfirmErrorState({required this.errorMessage});
}

final class MedicationUpdateLoadingState extends MedicationState {}

final class MedicationUpdateSuccessState extends MedicationState {
  final MedicationResponse medicationResponse;

  MedicationUpdateSuccessState({required this.medicationResponse});
}

final class MedicationUpdateErrorState extends MedicationState {
  final String errorMessage;

  MedicationUpdateErrorState({required this.errorMessage});
}

final class MedicationListLoadingState extends MedicationState {}

final class MedicationListSuccessState extends MedicationState {
  final MedicationList medications;

  MedicationListSuccessState({required this.medications});
}

final class MedicationListErrorState extends MedicationState {
  final String errorMessage;

  MedicationListErrorState({required this.errorMessage});
}