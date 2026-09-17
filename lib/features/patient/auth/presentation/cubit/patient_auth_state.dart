import 'package:chefaa/features/patient/auth/domain/entities/register_patient_response_entity.dart';

sealed class PatientAuthState {}

class AuthInitialState extends PatientAuthState{}
class RegisterLoadingState extends PatientAuthState {}

class RegisterSuccessState extends PatientAuthState {
  final RegisterPatientResponseEntity authResult;

  RegisterSuccessState(this.authResult);
}

class RegisterErrorState extends PatientAuthState {
  final String message;

  RegisterErrorState(this.message);
}