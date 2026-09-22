import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_app_bar.dart';

class CustomAppBarLayout extends StatelessWidget {
  final String title1;
  final String title2;
  final VoidCallback? onPressed;
  final bool hasUnreadNotifications;

  const CustomAppBarLayout({
    super.key,
    required this.title1,
    required this.title2,
    this.onPressed,
    this.hasUnreadNotifications = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: ColorManager.input,
                child: ClipOval(
                  child: Image.asset(
                    "assets/images/patient.png",
                    width: 100,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 20),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    title2,
                    style: const TextStyle(
                      color: ColorManager.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),

          IconButton(
            onPressed: onPressed,
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/notification.svg",
                    height: 20,
                    width: 20,
                  ),
                ),

                if (hasUnreadNotifications)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/notification_full.svg",
                      height: 20.h,
                      width: 20.w,
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
