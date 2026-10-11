// في ملف cart_icon_button.dart
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_cubit.dart';
import 'package:chefaa/features/patient/cart/presentation/cubit/cart_state.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model/data..dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartIconButton extends StatelessWidget {
  final Data? pharmacyData;

  const CartIconButton({super.key, this.pharmacyData});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final itemCount = context.read<CartCubit>().items.length;

        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              onPressed: () {
                final currentPharmacy =
                    pharmacyData ?? context.read<CartCubit>().pharmacy;
                Navigator.pushNamed(
                  context,
                  Routes.cart,
                  arguments: currentPharmacy,
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: ColorManager.white,
                size: 24,
              ),
            ),
            if (itemCount > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
