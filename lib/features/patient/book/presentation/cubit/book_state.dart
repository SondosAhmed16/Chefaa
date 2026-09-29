import 'package:chefaa/features/patient/book/data/model/clinic.dart';
import 'package:chefaa/features/patient/book/data/model/slot.dart';

sealed class BookState {}

final class BookingInitialState extends BookState {}

final class BookingLoadingState extends BookState {}

final class BookingSuccessState extends BookState {
  final String? message;

  BookingSuccessState({required this.message});
}

final class BookingErrorState extends BookState {
  final String error;

  BookingErrorState({required this.error});
}

class GetSlotsLoadingState extends BookState {}

class GetSlotsSuccessState extends BookState {
  final List<Slot> slots;

  GetSlotsSuccessState(this.slots);
}

class GetSlotsErrorState extends BookState {
  final String message;

  GetSlotsErrorState(this.message);
}

class TimeSelectedState extends BookState {
  final String selectedTime;

  TimeSelectedState(this.selectedTime);
}

final class SlotsErrorState extends BookState {
  final String error;

  SlotsErrorState({required this.error});
}

class ChangeStepState extends BookState {}


class ClinicsLoadingState extends BookState{}

class ClinicsSuccessState extends BookState{
  final List<Clinic> clinics;

  ClinicsSuccessState({required this.clinics});
}

class ClinicsErrorState extends BookState{
  final String error;

  ClinicsErrorState({required this.error});
}


