import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class CartQuantityControl extends StatefulWidget {
  final int initialQuantity;
  final int minQuantity;
  final int maxQuantity;
  final ValueChanged<int>? onQuantityChanged;

  const CartQuantityControl({
    super.key,
    this.initialQuantity = 1,
    this.minQuantity = 1,
    this.maxQuantity = 99,
    this.onQuantityChanged,
  });

  @override
  State<CartQuantityControl> createState() => _CartQuantityControlState();
}

class _CartQuantityControlState extends State<CartQuantityControl> {
  late int _currentQuantity;

  @override
  void initState() {
    super.initState();
    _currentQuantity = widget.initialQuantity;
  }

  void _increment() {
    if (_currentQuantity < widget.maxQuantity) {
      setState(() {
        _currentQuantity++;
      });
      widget.onQuantityChanged?.call(_currentQuantity);
    }
  }

  void _decrement() {
    if (_currentQuantity > widget.minQuantity) {
      setState(() {
        _currentQuantity--;
      });
      widget.onQuantityChanged?.call(_currentQuantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.lightGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _currentQuantity > widget.minQuantity
                ? _decrement
                : null,
            icon: const Icon(Icons.remove, size: 18),
            color: _currentQuantity > widget.minQuantity
                ? ColorManager.primary
                : Colors.grey,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              '$_currentQuantity',
              style: getBoldStyle(color: ColorManager.black, fontSize: 15),
            ),
          ),

          IconButton(
            onPressed: _currentQuantity < widget.maxQuantity
                ? _increment
                : null,
            icon: const Icon(Icons.add, size: 18),
            color: _currentQuantity < widget.maxQuantity
                ? ColorManager.primary
                : Colors.grey,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            padding: EdgeInsets.zero,
            splashRadius: 20,
          ),
        ],
      ),
    );
  }
}
