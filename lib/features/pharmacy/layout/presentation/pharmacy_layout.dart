import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/cubit/pharmacy_chatbot_cubit.dart';
import 'package:chefaa/features/pharmacy/chatbot/presentation/pages/pharmacy_chatbot_screen.dart';
import 'package:chefaa/features/pharmacy/orders/presentation/cubit/pharm_orders_cubit.dart';
import 'package:chefaa/features/pharmacy/orders/presentation/pages/pharmacy_orders_view.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/cubit/pharmacy_profile_cubit.dart';
import 'package:chefaa/features/pharmacy/profile/presentation/pages/pharmacy_profile_screen.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/cubit/stock_cubit.dart';
import 'package:chefaa/features/pharmacy/stock/presentation/pages/stock_view.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../../../../core/di/injection_container.dart';

class PharmacyLayout extends StatefulWidget {
  const PharmacyLayout({super.key});

  @override
  State<PharmacyLayout> createState() => _PharmacyLayoutState();
}

class _PharmacyLayoutState extends State<PharmacyLayout> {
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
          create: (_) => getIt<PharmacyProfileCubit>()..getPharmacyProfile(),
          child: PharmacyProfileScreen(),
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
          create: (_) => getIt<PharmacyChatbotCubit>(),
          child: PharmacyChatbotScreen(),
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
        screen: BlocProvider(
          create: (_) => getIt<StockCubit>(),
          child: StockView(),
        ),
        item: ItemConfig(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset("assets/svg_images/stock_active.svg"),
          ),
          inactiveIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset("assets/svg_images/stock.svg"),
          ),
          title: "Stock",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
          iconSize: 20,
        ),
      ),

      PersistentTabConfig(
        screen: BlocProvider(
          create: (_) => getIt<PharmOrdersCubit>()..getOrders(),
          child: const PharmacyOrdersView(),
        ),
        item: ItemConfig(
          icon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset("assets/svg_images/order_active.svg"),
          ),
          inactiveIcon: SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset("assets/svg_images/order.svg"),
          ),
          title: "Orders",
          activeForegroundColor: ColorManager.primary,
          inactiveForegroundColor: ColorManager.gray,
          iconSize: 20,
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
