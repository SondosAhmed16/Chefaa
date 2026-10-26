import 'package:chefaa/core/DI/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';
import 'package:chefaa/features/doctor/appointment/presentation/pages/my_patients_screen.dart';
import 'package:chefaa/features/doctor/brief/presentation/cubit/doctor_brief_cubit.dart';
import 'package:chefaa/features/doctor/brief/presentation/pages/doctor_breif_screen.dart';
import 'package:chefaa/features/doctor/chatbot/presentation/cubit/doctor_chatbot_cubit.dart';
import 'package:chefaa/features/doctor/chatbot/presentation/pages/doctor_chatbot_screen.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_cubit.dart';
import 'package:chefaa/features/doctor/home/presentation/pages/doctor_clinics_screen.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_cubit.dart';
import 'package:chefaa/features/doctor/profile/presentation/pages/doctor_profile_screen.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class DoctorLayout extends StatefulWidget {
  const DoctorLayout({super.key});

  @override
  State<DoctorLayout> createState() => _DoctorLayoutState();
}

class _DoctorLayoutState extends State<DoctorLayout> {
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
          create: (_) => getIt<DoctorProfileCubit>()..getDoctorProfile(),
          child: DoctorProfileScreen(),
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
          create: (_) => getIt<DoctorChatbotCubit>(),
          child: DoctorChatbotScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/chat_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/chat.svg"),
          title: "Chatbot",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),

      PersistentTabConfig(
        screen: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<DoctorHomeCubit>()),
            BlocProvider(
              create: (_) => getIt<UsersCubit>()..loadUserFromPrefs(),
            ),
          ],
          child: const DoctorClinicsScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/clinic_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/clinic.svg"),
          title: "Clinics",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<DoctorRepoCubit>()..getAppo(),
          child: MyPatientsScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/booking.svg"),
          inactiveIcon: SvgPicture.asset(
            "assets/svg_images/booking_inactive.svg",
          ),
          title: "Appointments",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<DoctorBriefCubit>()..getDoctorBrief(),
          child: DoctorBriefScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/doc_brief_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/doc_brief.svg"),
          title: "Daily Breif",
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
