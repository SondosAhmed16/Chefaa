import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class DaysAvaliable extends StatelessWidget {
  final String day;
  final bool avaliable;
  const DaysAvaliable({super.key, required this.day, required this.avaliable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: avaliable
            ? ColorManager.primary.withAlpha(30)
            : ColorManager.input,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        day,
        style: getBoldStyle(
          color: avaliable ? ColorManager.primary : ColorManager.input,
          fontSize: 13,
        ),
      ),
    );
  }
}
