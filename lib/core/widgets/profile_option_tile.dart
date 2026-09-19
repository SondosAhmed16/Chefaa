import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';

class ProfileOptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final String iconPath;

  const ProfileOptionTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        onTap: onTap,
        tileColor: ColorManager.lightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(color: ColorManager.input),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 4.0,
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ColorManager.transparent.withOpacity(0),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(iconPath),
        ),
        title: Text(
          title,
          style: getBoldStyle(fontSize: 14, color: ColorManager.black),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: getRegularStyle(fontSize: 12, color: ColorManager.gray),
              )
            : null,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: ColorManager.gray,
        ),
      ),
    );
  }
}
