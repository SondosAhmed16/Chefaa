import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoleCard extends StatelessWidget {
  final String title;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              color: ColorManager.gray,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(image, width: 70, height: 70, fit: BoxFit.contain),

            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: getBoldStyle(fontSize: 16, color: ColorManager.gray600),
              ),
            ),

            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorManager.primary, width: 2),
                color: isSelected ? ColorManager.primary : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
