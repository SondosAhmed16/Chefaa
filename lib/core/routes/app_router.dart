// lib/core/routes/app_router.dart
import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/pages/forget_password_screen.dart';
import 'package:chefaa/features/auth/presentation/pages/login_screen.dart';
import 'package:chefaa/features/auth/presentation/pages/reset_password_screen.dart';
import 'package:chefaa/features/auth/presentation/pages/verify_code_screen.dart';
import 'package:chefaa/features/onboarding/presentation/pages/facility_selection_screen.dart';
import 'package:chefaa/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:chefaa/features/onboarding/presentation/pages/role_selection_screen.dart';
import 'package:chefaa/features/splash/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String roleSelection = '/roleSelection';
  static const String facilitySelection = '/facilitySelection';
  static const String login = '/login';
  static const String home = '/home';
  static const String signUp = '/signUp';
  static const String forgetPassword = '/forgetPass';
  static const String verifyCode = '/verifyCode';
  static const String resetPAss = '/resetPAss';
}

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case Routes.facilitySelection:
        return MaterialPageRoute(
          builder: (_) => const FacilitySelectionScreen(),
        );

      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );

      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case Routes.verifyCode:
        final authCubit = settings.arguments as AuthCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const VerifyCodeScreen(),
          ),
        );

      case Routes.resetPAss:
        final authCubit = settings.arguments as AuthCubit;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: const ResetPasswordScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
