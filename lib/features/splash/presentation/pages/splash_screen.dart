import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/services/share_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkNanigation();
  }

  Future<void> _checkNanigation() async {
    await Future.delayed(const Duration(seconds: 3));
    final isFirstTime = await ShareServices.getBool('isFirstTime') ?? true;
    if (!mounted) return;
    if (isFirstTime) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    } else {
      Navigator.pushReplacementNamed(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(child: Image.asset("assets/images/icon.png", width: 420)),
    );
  }
}
