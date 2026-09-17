import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:flutter/material.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        },
        child: RichText(
          text: TextSpan(
            style: getRegularStyle(fontSize: 13, color: ColorManager.gray),
            children: [
              const TextSpan(text: "Do you already have an account? "),
              TextSpan(
                text: "Login",
                style: getBoldStyle(
                  fontSize: 13,
                  color: ColorManager.primary,
                ).copyWith(decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
