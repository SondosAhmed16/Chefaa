import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/role_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FacilityType { pharmacy, lab }

class FacilitySelectionScreen extends StatefulWidget {
  const FacilitySelectionScreen({super.key});

  @override
  State<FacilitySelectionScreen> createState() =>
      _FacilitySelectionScreenState();
}

class _FacilitySelectionScreenState extends State<FacilitySelectionScreen> {
  FacilityType? _facilityType;

  void _onNext() {
    if (_facilityType == null) return;
    if (_facilityType == FacilityType.pharmacy) {
      Navigator.pushNamed(context, Routes.roleSelection);
    } else if (_facilityType == FacilityType.lab) {
      Navigator.pushNamed(context, Routes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomHeader(),
            const SizedBox(height: 32),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      "Choose Facility",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 32),

                    RoleCard(
                      title: "Pharmacy",
                      image: "assets/images/drugs.png",
                      isSelected: _facilityType == FacilityType.pharmacy,
                      onTap: () =>
                          setState(() => _facilityType = FacilityType.pharmacy),
                    ),

                    const SizedBox(height: 32),
                    RoleCard(
                      title: "Medical Lab/\nRadiology Center",
                      image: "assets/images/lab.png",
                      isSelected: _facilityType == FacilityType.lab,
                      onTap: () =>
                          setState(() => _facilityType = FacilityType.lab),
                    ),

                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _facilityType != null ? _onNext : null,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _facilityType != null
                                ? ColorManager.primary
                                : ColorManager.darkGray,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            color: ColorManager.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
