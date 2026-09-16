import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/widgets.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: ColorManager.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/chefaa.png',
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
