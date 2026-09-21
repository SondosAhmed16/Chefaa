import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StateCard extends StatelessWidget {
  final String title;
  final String text;
  final String? iconPath;

  const StateCard({
    super.key,
    required this.title,
    required this.text,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(25),
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
          if (iconPath != null) ...[
            SvgPicture.asset(iconPath!),
            const SizedBox(width: 20),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: getRegularStyle(
                    color: ColorManager.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
