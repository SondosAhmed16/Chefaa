import 'dart:io';

import 'package:chefaa/features/facility/auth/domain/entity/facility_register_entity.dart';

sealed class FacilityAuthState {}

class AuthFacilityInitState extends FacilityAuthState {}

class AuthFacilityLoadingState extends FacilityAuthState {}

class MembershipFileUpdatedState extends FacilityAuthState {
  final File? memberShip;

  MembershipFileUpdatedState(  this.memberShip);
}

class AuthFacilitySuccessState extends FacilityAuthState {
  final FacilityRegisterEntity authResult;

  AuthFacilitySuccessState( this.authResult);
}

class AuthFacilityErrorState extends FacilityAuthState {
  final String message;

  AuthFacilityErrorState( this.message);
}
