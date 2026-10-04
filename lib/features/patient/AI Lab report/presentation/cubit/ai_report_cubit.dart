import 'dart:io';

import 'package:chefaa/features/patient/AI%20Lab%20report/domain/usecase/analyze_report_usecase.dart';
import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/cubit/ai_report_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiReportCubit extends Cubit<AiReportState> {
  final AnalyzeReportUsecase usecase;

  AiReportCubit({required this.usecase}) : super(AiReportInitialState());

  static AiReportCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> analyzeReport({required File labReport}) async {
    if (!isClosed) emit(AiReportLoadingState());
    final result = await usecase.call(labReport: labReport);
    return result.fold(
      (error) => emit(AiReportErrorState(error: error)),
      (report) => emit(AiReportSuccessState(data: report)),
    );
  }
}
