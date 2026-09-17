import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/role_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum RoleType { doctor, patient, facility }

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  RoleType? _selectedRole;

  void _onNext() {
    if (_selectedRole == null) return;
    if (_selectedRole == RoleType.facility) {
      Navigator.pushNamed(context, Routes.facilitySelection);
    } else if (_selectedRole == RoleType.patient) {
      Navigator.pushNamed(context, Routes.login);
    } else if (_selectedRole == RoleType.doctor) {
      Navigator.pushNamed(context, Routes.forgetPassword);
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
            SizedBox(height: 32),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      "Choose who YOu Are",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 32),

                    RoleCard(
                      title: "Doctor",
                      image: "assets/images/doctor.png",
                      isSelected: _selectedRole == RoleType.doctor,
                      onTap: () =>
                          setState(() => _selectedRole = RoleType.doctor),
                    ),
                    const SizedBox(height: 32),

                    RoleCard(
                      title: "Patient",
                      image: "assets/images/patient.png",
                      isSelected: _selectedRole == RoleType.patient,
                      onTap: () =>
                          setState(() => _selectedRole = RoleType.patient),
                    ),
                    const SizedBox(height: 32),

                    RoleCard(
                      title: "Facility",
                      image: "assets/images/drugs.png",
                      isSelected: _selectedRole == RoleType.facility,
                      onTap: () =>
                          setState(() => _selectedRole = RoleType.facility),
                    ),

                    const Spacer(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _selectedRole != null ? _onNext : null,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selectedRole != null
                                ? ColorManager.primary
                                : ColorManager.darkGray,
                          ),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24,)
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
