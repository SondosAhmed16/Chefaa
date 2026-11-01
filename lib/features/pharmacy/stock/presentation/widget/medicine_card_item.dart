import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/pharmacy/stock/data/model/get_stock_model/medicine.dart';
import 'package:flutter/material.dart';

class MedicineCardItem extends StatelessWidget {
  final Medicine medicine;
  final VoidCallback onTap;

  const MedicineCardItem({
    super.key,
    required this.medicine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = medicine.quantity ?? 0;
    final minThreshold = medicine.minThreshold ?? 10;

    Color badgeBgColor;
    Color badgeTextColor;
    String badgeText;

    if (quantity == 0) {
      badgeBgColor = ColorManager.lightRed;
      badgeTextColor = ColorManager.red600;
      badgeText = 'Out';
    } else if (quantity < (minThreshold / 2)) {
      badgeBgColor = ColorManager.lightRed;
      badgeTextColor = ColorManager.red600;
      badgeText = 'Low';
    } else if (quantity <= minThreshold) {
      badgeBgColor = ColorManager.amber100;
      badgeTextColor = ColorManager.amber600;
      badgeText = 'Low';
    } else {
      badgeBgColor = ColorManager.green100;
      badgeTextColor = ColorManager.green600;
      badgeText = 'In Stock';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    medicine.medicineName ?? 'Unknown',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badgeText,
                    style: getBoldStyle(color: badgeTextColor, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              medicine.category ?? '',
              style: getRegularStyle(color: ColorManager.h2Color, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightBlue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Stock: $quantity / $minThreshold',
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  'Price: ${medicine.price ?? 0} EGP',
                  style: getBoldStyle(color: ColorManager.black, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
