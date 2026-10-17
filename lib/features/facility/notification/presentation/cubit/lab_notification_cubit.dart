import 'package:chefaa/features/facility/notification/domain/usecase/get_lab_notification_usecase.dart';
import 'package:chefaa/features/facility/notification/presentation/cubit/lab_notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabNotificationCubit extends Cubit<LabNotificationState> {
  final GetLabNotificationUsecase getLabNotificationUsecase;

  LabNotificationCubit({required this.getLabNotificationUsecase})
    : super(LabNotificationInitial());

  Future<void> getLabNotification() async {

if(!isClosed) emit(LabNotificationLoading());

    final result = await getLabNotificationUsecase.call();

    result.fold(
      (error) => emit(LabNotificationError(error: error)),
      (notification) =>
          emit(LabNotificationSuccess(notification: notification)),
    );
  }
}
