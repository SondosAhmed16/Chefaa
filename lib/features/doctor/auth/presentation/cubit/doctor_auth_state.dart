import 'package:chefaa/features/doctor/auth/domain/entities/register_doctor_response_entity.dart';

sealed class DoctorAuthState {}

class AuthDoctorInitialState extends DoctorAuthState{}
class RegisterDoctorLoadingState extends DoctorAuthState {}

class RegisterOctorSuccessState extends DoctorAuthState {
  final RegisterDoctorResponseEntity authResult;

  RegisterOctorSuccessState(this.authResult);
}

class RegisterDoctorErrorState extends DoctorAuthState {
  final String message;

  RegisterDoctorErrorState(this.message);
}