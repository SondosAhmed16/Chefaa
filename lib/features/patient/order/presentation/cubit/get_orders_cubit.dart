import 'package:chefaa/features/patient/order/domain/usecase/get_orders_usecase.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/get_orders_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetOrdersCubit extends Cubit<GetOrdersState> {
  final GetOrdersUsecase usecase;

  GetOrdersCubit({required this.usecase}) : super(GetOrdersInitial());

  Future<void> getOrders() async {
    emit(GetOrdersLoading());
    final result = await usecase.call();
    result.fold(
      (error) => emit(GetOrdersError(error: error)),
      (orders) => emit(GetOrdersSuccess(orders: orders)),
    );
  }
}
