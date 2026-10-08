import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_medicienes_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_search_model.dart';

sealed class PharmacySearchState {}

class PharmacySearchInitial extends PharmacySearchState {}

class PharmacySearchLoading extends PharmacySearchState {}

class PharmacySearchSuccess extends PharmacySearchState {
  final PharmacySearchModel response;
  PharmacySearchSuccess(this.response);
}

class PharmacySearchFailure extends PharmacySearchState {
  final ErrorModel message;
  PharmacySearchFailure(this.message);
}



/***************************************************** */


 class PharmacyProfileLoading extends PharmacySearchState {}

 class PharmacyProfileSuccess extends PharmacySearchState {
  final PharmacyProfileModel pharmacyProfile;

  PharmacyProfileSuccess(this.pharmacyProfile);
}

 class PharmacyProfileFailure extends PharmacySearchState {
  final ErrorModel message;

  PharmacyProfileFailure(this.message);
}

/***************************************************** */

class PharmacyMedicinesLoading extends PharmacySearchState {}

class PharmacyMedicinesSuccess extends PharmacySearchState {
  final PharmacyMedicienesModel response;

  PharmacyMedicinesSuccess(this.response);
}

class PharmacyMedicinesFailure extends PharmacySearchState {
  final ErrorModel message;

  PharmacyMedicinesFailure(this.message);
}