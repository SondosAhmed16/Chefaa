
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTheme {
  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: ColorManager.white,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.lightGray,
      hintStyle: getSemiBoldStyle(
        color: ColorManager.gray,
        fontSize: FontSize.s16,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: const BorderSide(color: ColorManager.input, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: const BorderSide(color: ColorManager.input, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: const BorderSide(color: ColorManager.gray, width: 2.0),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.r),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
    ),
  );
}