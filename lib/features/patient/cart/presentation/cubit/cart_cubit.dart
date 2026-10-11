import 'package:chefaa/features/patient/cart/data/model/cart_model.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model/data..dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({this.pharmacy}) : super(CartInitial()) {
    if (pharmacy?.cityDeliveryPrices != null &&
        pharmacy!.cityDeliveryPrices!.isNotEmpty) {
      _selectedCity = pharmacy!.cityDeliveryPrices![0].city;
    }
  }
  void updatePharmacy(Data? newPharmacy) {
    if (newPharmacy != null && pharmacy?.id != newPharmacy.id) {
      pharmacy = newPharmacy;
      if (pharmacy?.cityDeliveryPrices != null &&
          pharmacy!.cityDeliveryPrices!.isNotEmpty) {
        _selectedCity = pharmacy!.cityDeliveryPrices![0].city;
      }
      _emitCartUpdate();
    }
  }

  final List<CartItemModel> _cartItems = [];
  Data? pharmacy;

  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  void selectCity(String city) {
    _selectedCity = city;
    _emitCartUpdate();
  }

  int get deliveryFee {
    if (pharmacy?.cityDeliveryPrices == null || _selectedCity == null) return 0;

    final deliveryPriceObj = pharmacy!.cityDeliveryPrices!.firstWhere(
      (element) => element.city == _selectedCity,
      orElse: () => pharmacy!.cityDeliveryPrices![0],
    );

    return deliveryPriceObj.price ?? 0;
  }

  List<CartItemModel> get items => List.unmodifiable(_cartItems);

  double get subtotal =>
      _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get total => _cartItems.isEmpty ? 0.0 : subtotal + deliveryFee;

  void _emitCartUpdate() {
    emit(
      CartUpdatedState(
        items: List.from(_cartItems),
        subtotal: subtotal,
        deliveryFee: _cartItems.isEmpty ? 0 : deliveryFee,
        total: total,
      ),
    );
  }

  void addToCart(CartItemModel item, {Data? pharmacyData}) {
    if (pharmacyData != null) {
      updatePharmacy(pharmacyData);
    }

    final index = _cartItems.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      final newQuantity = _cartItems[index].quantity + item.quantity;
      _cartItems[index].quantity = newQuantity.clamp(
        1,
        _cartItems[index].maxQuantity,
      );
    } else {
      _cartItems.add(item);
    }
    _emitCartUpdate();
  }

  void updateQuantity(String itemId, int newQuantity) {
    final index = _cartItems.indexWhere((e) => e.id == itemId);
    if (index != -1) {
      if (newQuantity <= 0) {
        removeFromCart(itemId);
      } else {
        _cartItems[index].quantity = newQuantity.clamp(
          1,
          _cartItems[index].maxQuantity,
        );
        _emitCartUpdate();
      }
    }
  }

  void removeFromCart(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _emitCartUpdate();
  }

  void clearCart() {
    _cartItems.clear();
    _emitCartUpdate();
  }
}
