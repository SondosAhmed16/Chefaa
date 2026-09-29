import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String type;
  final String imgPath;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isGroupHeader;
  const PaymentMethodCard({
    super.key,
    required this.type,
    required this.imgPath,
    required this.isSelected,
    required this.onTap,
    this.isGroupHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? ColorManager.primary : ColorManager.input;
    final borderWidth = isSelected ? 2.0 : 1.0;

    return Material(
      color: ColorManager.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Ink(
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: isGroupHeader
                ? const BorderRadius.vertical(top: Radius.circular(25))
                : BorderRadius.circular(25),

            border: isGroupHeader
                ? Border(
                    left: BorderSide(color: borderColor, width: borderWidth),
                    right: BorderSide(color: borderColor, width: borderWidth),
                    top: BorderSide(color: borderColor, width: borderWidth),
                    bottom: BorderSide.none,
                  )
                : Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 50,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: borderColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                  color: borderColor,
                ),
              ),

              const SizedBox(width: 24),
              Text(
                type,
                style: getBoldStyle(color: ColorManager.black, fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
