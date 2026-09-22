import 'package:chefaa/core/resources/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;
  final Color? backgroundColor;
  final double? elevation;
  final double? preferredHeight;
  final EdgeInsets? padding;
  final double? borderRadiusValue;

  const CustomAppBar({
    super.key,
    required this.child,
    this.backgroundColor,
    this.elevation,
    this.preferredHeight,
    this.padding,
    this.borderRadiusValue,
  });

  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? 110);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: backgroundColor ?? ColorManager.primary,
      shadowColor: ColorManager.black.withValues(alpha: .25),
      elevation: elevation ?? 15,
      flexibleSpace: SafeArea(
        child: Padding(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: child,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(borderRadiusValue ?? 30),
        ),
      ),
    );
  }
}
