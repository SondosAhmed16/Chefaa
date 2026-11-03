import 'package:chefaa/features/facility/dashboard/domain/usecase/get_lab_dashboard_usecase.dart';
import 'package:chefaa/features/facility/requests/domain/repository/requests_repo.dart';
import 'package:chefaa/features/facility/requests/presentation/cubit/requests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsCubit extends Cubit<RequestsState> {
  final RequestsRepo requestsRepo;
  final GetLabDashboardUsecase getLabDashboardUsecase;

  RequestsCubit({
    required this.requestsRepo,
    required this.getLabDashboardUsecase,
  }) : super(RequestsStateInitial());

  Future<void> addRequest({required Map<String, dynamic> body}) async {
    if (!isClosed) emit(AddLoading());

    final result = await requestsRepo.addRequest(body: body);

    result.fold((error) => emit(AddError(error: error)), (
      addRequestModel,
    ) async {
      emit(AddSuccess(addRequestModel: addRequestModel));
      await getLabDashboardUsecase.call();
    });
  }

  Future<void> uploadResult({required Map<String, dynamic> body}) async {
    if (!isClosed) emit(UploadResultLoading());

    final result = await requestsRepo.uploadResult(body: body);

    result.fold((error) => emit(UploadResultError(error: error)), (
      uploadResultModel,
    ) async {
      emit(UploadResultSuccess(uploadResultModel: uploadResultModel));
      await getLabDashboardUsecase.call();
    });
  }
}
