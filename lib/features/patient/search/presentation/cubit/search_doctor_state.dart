import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/search/domain/entity/doctor_entity.dart';

abstract class SearchDoctorState {}

// Initial State
class SearchDoctorInitialState extends SearchDoctorState {}

// Search States
class SearchDoctorLoadingState extends SearchDoctorState {}

class SearchDoctorSuccessState extends SearchDoctorState {
  final List<DoctorEntity> doctors;
  SearchDoctorSuccessState(this.doctors);
}

class SearchDoctorErrorState extends SearchDoctorState {
  final ErrorModel errorModel;
  SearchDoctorErrorState(this.errorModel);
}

// History States
class SearchHistoryLoadingState extends SearchDoctorState {}

class SearchHistoryLoadedState extends SearchDoctorState {
  final List<String> historyList;
  SearchHistoryLoadedState(this.historyList);
}

class SearchHistoryErrorState extends SearchDoctorState {
  final ErrorModel errorModel;
  SearchHistoryErrorState(this.errorModel);
}