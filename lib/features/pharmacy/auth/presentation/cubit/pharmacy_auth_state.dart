import 'dart:io';

import 'package:chefaa/features/pharmacy/auth/domain/entities/register_pharmacy_response_entity.dart';

sealed class PharmacyAuthState {}

class AuthPharmacyInitialState extends PharmacyAuthState {}

class RegisterPharmacyLoadingState extends PharmacyAuthState {}

class MembershipFileUpdatedState extends PharmacyAuthState {
  final File? file;
  MembershipFileUpdatedState(this.file);
}

class RegisterPharmacySuccessState extends PharmacyAuthState {
  final RegisterPharmacyResponseEntity authResult;
  RegisterPharmacySuccessState(this.authResult);
}

class RegisterPharmacyErrorState extends PharmacyAuthState {
  final String message;
  RegisterPharmacyErrorState(this.message);
}
