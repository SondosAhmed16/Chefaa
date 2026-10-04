import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/data/model/data.dart';

sealed class AiReportState {}

class AiReportInitialState extends AiReportState {}

class AiReportLoadingState extends AiReportState {}

class AiReportSuccessState extends AiReportState {
  final Data data;

  AiReportSuccessState({required this.data});
}

class AiReportErrorState extends AiReportState {
  final ErrorModel error;

  AiReportErrorState({required this.error});
}
