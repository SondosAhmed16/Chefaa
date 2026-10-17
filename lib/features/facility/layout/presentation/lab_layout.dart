import 'package:chefaa/core/DI/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/features/facility/dashboard/presentation/cubit/lab_dashboard_cubit.dart';
import 'package:chefaa/features/facility/dashboard/presentation/pages/lab_dashboard_screen.dart';
import 'package:chefaa/features/facility/profile/presentation/cubit/lab_profile_cubit.dart';
import 'package:chefaa/features/facility/profile/presentation/pages/lab_profile_screen.dart';
import 'package:chefaa/features/facility/services/presentation/cubit/lab_services_cubit.dart';
import 'package:chefaa/features/facility/services/presentation/pages/center_services_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class LabLayout extends StatefulWidget {
  const LabLayout({super.key});

  @override
  State<LabLayout> createState() => _LabLayoutState();
}

class _LabLayoutState extends State<LabLayout> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> _buildTaps() {
    return [
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<LabProfileCubit>()..getLabProfile(),
          child: LabProfileScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/profile_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/profile.svg"),
          title: "Profile",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),

      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<LabServicesCubit>()..getCenterServices(),
          child: LabServicesScreen(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.list_alt_rounded),
          title: "Services",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),

      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<LabDashboardCubit>()..getLabDashboard(),
          child: LabDashboardScreen(),
        ),
        item: ItemConfig(
          icon: const Icon(Icons.space_dashboard_rounded),
          title: "Dashboard",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      tabs: _buildTaps(),
      navBarBuilder: (navBarConfig) =>
          Style1BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}

// class LabWrapper extends StatelessWidget {
//   const LabWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [BlocProvider(create: (_) => getIt<LabProfileCubit>())],
//       child: const LabProfileScreen(),
//     );
//   }
// }
