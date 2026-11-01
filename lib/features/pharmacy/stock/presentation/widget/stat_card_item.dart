import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/widgets.dart';

class StatCardItem extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  const StatCardItem({
    super.key,
    required this.title,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: getMediumStyle(color: ColorManager.gray, fontSize: 12),
          ),
          const SizedBox(height: 6),
          Text(count, style: getBoldStyle(color: color, fontSize: 18)),
        ],
      ),
    );
  }
}
