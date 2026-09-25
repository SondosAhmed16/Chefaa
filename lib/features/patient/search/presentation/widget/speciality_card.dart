import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecialityCard extends StatelessWidget {
  final Map<String, String> item;
  final VoidCallback? onTap;

  const SpecialityCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            Navigator.pop(context, item["specialityName"]);
          },
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: .1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(item["specialityImage"]!, fit: BoxFit.contain),
            ),
          ),
          6.verticalSpace,
          Text(
            item["specialityName"]!,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}