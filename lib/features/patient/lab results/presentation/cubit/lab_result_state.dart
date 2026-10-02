import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';

sealed class LabResultState {}

class LabResultInitialState extends LabResultState {}

class LabResultLooadingState extends LabResultState {}

class LabResultSuccessState extends LabResultState {
  final List<Result> results;

  LabResultSuccessState({required this.results});
}

class LabResultErrorState extends LabResultState {
  final ErrorModel error;

  LabResultErrorState({required this.error});
}
