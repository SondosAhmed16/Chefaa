import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/onboarding/domain/entity/patient_all_info_entity.dart';

abstract class AllInfoState {}

class AllInfoInitialState extends AllInfoState {}

class AllInfoPageChangedState extends AllInfoState {
  final int pageIndex;
  AllInfoPageChangedState(this.pageIndex);
}

class AllInfoFormUpdatedState extends AllInfoState {}

class AllInfoLoadingState extends AllInfoState {}

class AllInfoSuccessState extends AllInfoState {
  final PatientInfoResEntity response;
  AllInfoSuccessState(this.response);
}

class AllInfoErrorState extends AllInfoState {
  final ErrorModel error;
  AllInfoErrorState(this.error);
}
