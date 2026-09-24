import 'package:chefaa/features/patient/notification/data/model/notification_response.dart';
import 'package:chefaa/features/patient/notification/domain/usecase/get_notification_usecase.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationUsecase usecase;

  NotificationCubit({required this.usecase}) : super(NotificationInitState());

  static NotificationCubit get(BuildContext context) =>
      BlocProvider.of<NotificationCubit>(context);

  Future<void> getNotification() async {
    emit(NotificationLoadingState());
    final result = await usecase();

    result.fold(
      (error) {
        emit(NotificationErrorState(errorMessage: error.message));
      },
      (result) {
        emit(NotificationSuccessState(notification: result));
      },
    );
  }

   Future<void> markAsRead(NotificationResponse notification ) async {
    notification.isRead = true;

    if (state is NotificationSuccessState) {
      if (!isClosed) {
        emit(
        NotificationSuccessState(
          notification: List.from(
            (state as NotificationSuccessState).notification,
          ),
        ),
      );
      }
    }
  }
}
