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
