import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20search/data/model/center.dart';

sealed class LabSearchState {}

class LabSearchInitialState extends LabSearchState {}

class LabSearchLoadingState extends LabSearchState {}

class LabSearchSuccessState extends LabSearchState {
  final List<CenterModel> centers;

  LabSearchSuccessState({required this.centers});
}

class LabSearchErrorState extends LabSearchState {
  final ErrorModel error;

  LabSearchErrorState(this.error);
}
