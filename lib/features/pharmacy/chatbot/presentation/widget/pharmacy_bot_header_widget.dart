import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class PharmacyBotHeaderWidget extends StatelessWidget {
  const PharmacyBotHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            "I'm here to help you manage your Pharmacy,\nRevenue, and Orders easily.",
            textAlign: TextAlign.center,
            style: getRegularStyle(color: ColorManager.gray, fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
