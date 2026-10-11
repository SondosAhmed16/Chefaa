import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_cubit.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_state.dart';
import 'package:chefaa/features/patient/order/presentation/pages/checkout_screen.dart';
import 'package:chefaa/features/patient/pharmacy%20search/presentation/widget/cart_quantity_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 20,
          ),
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "My Cart",
                style: getBoldStyle(color: ColorManager.white, fontSize: 22),
              ),
              const SizedBox(height: 4),
              Text(
                "Check your items before placing order",
                style: getMediumStyle(
                  color: ColorManager.white.withOpacity(0.9),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();
          final items = cubit.items;

          if (items.isEmpty) {
            return Center(
              child: Text(
                "Your cart is empty",
                style: getBoldStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // قائمة المنتجات في السلة
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: ColorManager.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.name,
                                      style: getBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "EGP ${item.price.toStringAsFixed(2)} per unit",
                                      style: getMediumStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cubit.removeFromCart(item.id);
                                },
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Colors.redAccent,
                                  size: 22,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CartQuantityControl(
                                initialQuantity: item.quantity,
                                minQuantity: 1,
                                maxQuantity: item.maxQuantity,
                                onQuantityChanged: (newQuantity) {
                                  cubit.updateQuantity(item.id, newQuantity);
                                },
                              ),
                              Text(
                                "EGP ${item.totalPrice.toStringAsFixed(2)}",
                                style: getBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManager.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal Total",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "EGP ${cubit.subtotal.toStringAsFixed(2)}",
                        style: getBoldStyle(
                          color: ColorManager.primary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                CustemButton(
                  text: "Proceed To Checkout",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: cubit,
                          child: const CheckoutScreen(),
                        ),
                      ),
                    );
                  },
                  isLoading: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
