import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/pharmacy/orders/data/model/get_orders_model/get_orders_model.dart';
import 'package:chefaa/features/pharmacy/orders/domain/repository/pharm_order_repo.dart';
import 'pharm_orders_state.dart';

class PharmOrdersCubit extends Cubit<PharmOrdersState> {
  final PharmOrderRepo pharmOrderRepo;

  PharmOrdersCubit({required this.pharmOrderRepo})
    : super(PharmOrdersInitialState());

  static PharmOrdersCubit get(context) => BlocProvider.of(context);

  GetOrdersModel? getOrdersModel;

  Future<void> getOrders({String? status}) async {
    emit(GetOrdersLoadingState());
    final result = await pharmOrderRepo.getOrders(status: status);

    result.fold((error) => emit(GetOrdersErrorState(error)), (ordersModel) {
      getOrdersModel = ordersModel;
      emit(GetOrdersSuccessState(ordersModel));
    });
  }

  Future<void> acceptOrder({required String orderId}) async {
    emit(AcceptOrderLoadingState(orderId));
    final result = await pharmOrderRepo.acceptOrder(orderId: orderId);

    result.fold((error) => emit(AcceptOrderErrorState(error)), (
      orderStatModel,
    ) {
      emit(AcceptOrderSuccessState(orderStatModel));
      getOrders();
    });
  }

  Future<void> readyOrder({required String orderId}) async {
    emit(ReadyOrderLoadingState(orderId));
    final result = await pharmOrderRepo.readyOrder(orderId: orderId);

    result.fold((error) => emit(ReadyOrderErrorState(error)), (orderStatModel) {
      emit(ReadyOrderSuccessState(orderStatModel));
      getOrders();
    });
  }

  Future<void> completeOrder({required String orderId}) async {
    emit(CompleteOrderLoadingState(orderId));
    final result = await pharmOrderRepo.completeOrder(orderId: orderId);

    result.fold((error) => emit(CompleteOrderErrorState(error)), (
      orderStatModel,
    ) {
      emit(CompleteOrderSuccessState(orderStatModel));
      getOrders();
    });
  }
}
