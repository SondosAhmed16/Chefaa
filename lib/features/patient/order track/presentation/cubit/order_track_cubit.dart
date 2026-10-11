import 'package:chefaa/features/patient/order%20track/domain/usecase/confirm_order_usecase.dart';
import 'package:chefaa/features/patient/order%20track/domain/usecase/order_track_usecase.dart';
import 'package:chefaa/features/patient/order%20track/presentation/cubit/order_track_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderTrackCubit extends Cubit<OrderTrackState> {
  final OrderTrackUsecase usecase;
  final ConfirmOrderUsecase confirmOrderUsecase;

  OrderTrackCubit({required this.usecase, required this.confirmOrderUsecase})
    : super(OrderTrackInitial());

  Future<void> orderTack({required String orderId}) async {
    if (!isClosed) emit(OrderTrackLoading());

    final result = await usecase.call(orderId: orderId);
    result.fold(
      (error) => emit(OrderTrackError(error: error)),
      (model) => emit(OrderTrackSuccess(model: model)),
    );
  }

  Future<void> orderConfirm({required String orderId}) async {
    if (!isClosed) emit(OrderConfirmLoading());

    final result = await confirmOrderUsecase.call(orderId: orderId);
    result.fold(
      (error) => emit(OrderConfirmError(error: error)),
      (model) => emit(OrderConfirmSuccess(model: model)),
    );
  }
}
