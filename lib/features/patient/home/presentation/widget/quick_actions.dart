import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class QuickActions extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const QuickActions({
    super.key,
    required this.onTap,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(25),
          splashColor: ColorManager.gray.withAlpha(90),
          highlightColor: ColorManager.gray.withAlpha(90),
          onTap: () {
            onTap();
          },
          child: Container(
            height: 60.h,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(25.r),
              border: Border.all(color: ColorManager.gray),
            ),
            child: SvgPicture.asset(image, width: 35, height: 35),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          height: 40.h,
          child: Text(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(color: ColorManager.black, fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
