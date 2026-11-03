import 'package:chefaa/core/error%20handle/error_model.dart';
import 'package:chefaa/features/facility/requests/data/model/add_request_model/add_request_model.dart';
import 'package:chefaa/features/facility/requests/data/model/upload_result_model/upload_result_model.dart';

sealed class RequestsState {}

class RequestsStateInitial extends RequestsState {}

class AddLoading extends RequestsState {}

class AddSuccess extends RequestsState {
  final AddRequestModel addRequestModel;

  AddSuccess({required this.addRequestModel});
}

class AddError extends RequestsState {
  final ErrorModel error;

  AddError({required this.error});
}

class UploadResultLoading extends RequestsState {}

class UploadResultSuccess extends RequestsState {
  final UploadResultModel uploadResultModel;

  UploadResultSuccess({required this.uploadResultModel});
}

class UploadResultError extends RequestsState {
  final ErrorModel error;

  UploadResultError({required this.error});
}
