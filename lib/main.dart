// lib/main.dart
import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppModule();

  runApp(ChefaaApp(appRouter: AppRouter()));
}

class ChefaaApp extends StatelessWidget {
  final AppRouter appRouter;

  const ChefaaApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chefaa',
          initialRoute: Routes.splash,
          // home: MyMedicationsScreen(),
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
