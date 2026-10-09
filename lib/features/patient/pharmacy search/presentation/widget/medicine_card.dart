import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/medicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MedicineCard extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;
  const MedicineCard({
    super.key,
    required this.medicine,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withAlpha(60),
              blurRadius: 10,
              offset: const Offset(4, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine.medicineName ?? " ",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        medicine.dosageForm ?? " ",
                        style: getMediumStyle(color: ColorManager.gray),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: onAddToCart,
                  icon: Icon(
                    Icons.shopping_cart_rounded,
                    color: ColorManager.white,
                    size: 18,
                  ),
                  label: Text(
                    "Add To Cart",
                    style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: 13,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: ColorManager.blue100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "${medicine.price ?? 0.0} EGP",
                style: getBoldStyle(color: ColorManager.primary, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
