import 'package:chefaa/features/patient/appointment/data/model/datum.dart';

sealed class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final List<Datum> appointments;
  AppointmentSuccess(this.appointments);
}

class AppointmentError extends AppointmentState {
  final String message;
  AppointmentError(this.message);
}

// Reschedule States
class RescheduleLoadingState extends AppointmentState {}

class RescheduleSuccessState extends AppointmentState {
  final Datum appointment;
  RescheduleSuccessState({required this.appointment});
}

class RescheduleErrorState extends AppointmentState {
  final String error;
  RescheduleErrorState({required this.error});
}

// Cancel States
class CancelLoadingState extends AppointmentState {}

class CancelSuccessState extends AppointmentState {
  final Datum? appointment;
  CancelSuccessState({this.appointment});
}

class CancelErrorState extends AppointmentState {
  final String error;
  CancelErrorState({required this.error});
}
