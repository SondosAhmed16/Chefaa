import 'package:chefaa/features/patient/cart/data/model/cart_model.dart';

sealed class CartState {}

class CartInitial extends CartState {}

class CartUpdatedState extends CartState {
  final List<CartItemModel> items;
  final double subtotal;
  final int deliveryFee;
  final double total;

  CartUpdatedState({
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });
}
