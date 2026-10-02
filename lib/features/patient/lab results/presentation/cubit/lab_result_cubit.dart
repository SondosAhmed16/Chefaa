import 'package:chefaa/features/patient/lab%20results/domain/usecase/get_lab_results_usecase.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/cubit/lab_result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabResultCubit extends Cubit<LabResultState> {
  final GetLabResultsUsecase usecase;

  LabResultCubit({required this.usecase}) : super(LabResultInitialState());

  static LabResultCubit get(BuildContext context) =>
      BlocProvider.of<LabResultCubit>(context);

  Future<void> getLabResult() async {
    if (!isClosed) emit(LabResultLooadingState());
    final result = await usecase.call();
    result.fold(
      (error) => emit(LabResultErrorState(error: error)),
      (results) => emit(LabResultSuccessState(results: results)),
    );
  }
}
