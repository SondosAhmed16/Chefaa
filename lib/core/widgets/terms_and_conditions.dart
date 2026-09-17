import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  const TermsAndConditions({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: ColorManager.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: getRegularStyle(fontSize: 12, color: ColorManager.black),
              children: [
                const TextSpan(text: "I agree to the Docify "),
                TextSpan(
                  text: "Terms of Service ",
                  style: getBoldStyle(
                    fontSize: 12,
                    color: ColorManager.primary,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
                const TextSpan(text: "and "),
                TextSpan(
                  text: "Privacy Policy",
                  style: getBoldStyle(
                    fontSize: 12,
                    color: ColorManager.primary,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
