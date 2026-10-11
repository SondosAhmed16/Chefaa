import 'package:chefaa/features/patient/cart/presentation/cubit/cart_cubit.dart';
import 'package:chefaa/features/patient/order/domain/entity/order_request.dart';
import 'package:chefaa/features/patient/order/domain/usecase/checkout_usecase.dart';
import 'package:chefaa/features/patient/order/presentation/cubit/checkout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutUsecase checkoutUsecase;

  CheckoutCubit({required this.checkoutUsecase}) : super(CheckoutInitial());

  Future<void> createOrder({required OrderRequestModel orderRequest}) async {
    if (!isClosed) emit(CheckoutLoading());
    final result = await checkoutUsecase.call(orderRequest: orderRequest);
    result.fold(
      (error) => emit(CheckoutFailure(error)),
      (orderModel) => emit(CheckoutSuccess(orderModel)),
    );
  }

  Future<void> checkoutFromCart({
    required CartCubit cartCubit,
    required String fullName,
    required String phoneNumber,
    required String streetAddress,
    String paymentMethod = "Cash",
    String orderType = "Delivery",
  }) async {
    final List<OrderItemModel> orderItems = cartCubit.items.map((item) {
      return OrderItemModel(
        medicineId: item.id,
        medicineName: item.name,
        quantity: item.quantity,
      );
    }).toList();

    final coords = cartCubit.pharmacy?.location?.coordinates;
    List<double>? doubleCoordinates;
    if (coords != null && coords.length >= 2) {
      doubleCoordinates = [
        (coords[0] as num).toDouble(),
        (coords[1] as num).toDouble(),
      ];
    } else {
      doubleCoordinates = [31.2357, 30.0444];
    }

    final OrderRequestModel orderRequest = OrderRequestModel(
      pharmacyId: cartCubit.pharmacy?.id ?? "",
      orderType: orderType,
      paymentMethod: paymentMethod,
      items: orderItems,
      deliveryAddressDetails: DeliveryAddressDetails(
        fullName: fullName,
        phoneNumber: phoneNumber,
        cityDistrict: cartCubit.selectedCity ?? "",
        streetAddress: streetAddress,
        location: OrderLocation(type: "Point", coordinates: doubleCoordinates),
      ),
    );

    await createOrder(orderRequest: orderRequest);
  }
}
