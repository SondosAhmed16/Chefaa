import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/cubit/ai_report_cubit.dart';
import 'package:chefaa/features/patient/chatbot/presentation/cubit/chatbot_patient_cubit.dart';
import 'package:chefaa/features/patient/chatbot/presentation/pages/chatbot_screen.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_cubit.dart';
import 'package:chefaa/features/patient/profile/presentation/pages/patient_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/di/injection_container.dart';

import 'package:chefaa/features/patient/home/presentation/pages/home_patient.dart';
import 'package:chefaa/features/patient/home/presentation/cubit/user_cubit.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/notification/presentation/cubit/notification_cubit.dart';
import 'package:chefaa/features/patient/lab%20results/presentation/cubit/lab_result_cubit.dart';

import 'package:chefaa/features/patient/AI%20Lab%20report/presentation/pages/lab_report_uplaod_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
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

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: const HomePatientWrapper(),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/Home_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/Home.svg"),
          title: "Home",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<AiReportCubit>(),
          child: const LabReportUplaodScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset(
            "assets/svg_images/ai_lab_active.svg",
            height: 24,
            width: 24,
          ),
          inactiveIcon: SvgPicture.asset(
            "assets/svg_images/ai_lab.svg",
            height: 24,
            width: 24,
          ),
          title: "AI Report",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<ChatbotPatientCubit>(),
          child: const ChatbotScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/chat_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/chat.svg"),
          title: "Chat",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<PatientProfileCubit>()..getProfileData(),
          child: const PatientProfileScreen(),
        ),
        item: ItemConfig(
          icon: SvgPicture.asset("assets/svg_images/profile_active.svg"),
          inactiveIcon: SvgPicture.asset("assets/svg_images/profile.svg"),
          title: "Me",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _buildTabs(),
      navBarBuilder: (navBarConfig) =>
          Style1BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}

class HomePatientWrapper extends StatelessWidget {
  const HomePatientWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<UsersCubit>()),
        BlocProvider(create: (_) => getIt<AppointmentCubit>()),
        BlocProvider(
          create: (_) => getIt<MedicationCubit>()..getMedicationList(),
        ),
        BlocProvider(create: (_) => getIt<NotificationCubit>()),
        BlocProvider(create: (_) => getIt<LabResultCubit>()..getLabResult()),
      ],
      child: const HomePatient(),
    );
  }
}
