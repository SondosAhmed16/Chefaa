class CartItemModel {
  final String id;
  final String name;
  final String? dosage;
  final double price;
  int quantity;
  final int maxQuantity;

  CartItemModel({
    required this.id,
    required this.name,
    this.dosage,
    required this.price,
    this.quantity = 1,
    this.maxQuantity = 10,
  });

  double get totalPrice => price * quantity;
}
