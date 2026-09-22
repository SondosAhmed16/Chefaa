import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/profile_option_tile.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_cubit.dart';
import 'package:chefaa/features/patient/profile/presentation/cubit/profile_patient_state.dart';
import 'package:chefaa/features/patient/profile/presentation/widgets/bottomSheet_basic_info.dart';
import 'package:chefaa/features/patient/profile/presentation/widgets/bottomSheet_med_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: BlocConsumer<PatientProfileCubit, ProfilePatientState>(
        buildWhen: (previous, current) =>
            current is GetProfileLoadingState ||
            current is GetProfileSuccessState ||
            current is GetProfileErrorState ||
            current is UpdateBasicInfoSuccessState ||
            current is UpdateMedInfoSuccessState ||
            current is GenderChangedState ||
            current is BloodTypeChangedState,

        listener: (context, state) {
          if (state is GetProfileErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error.message)));
          }

          if (state is UpdateBasicInfoSuccessState ||
              state is UpdateMedInfoSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile updated successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = PatientProfileCubit.get(context);
          final profile = cubit.currentProfile;

          if (state is GetProfileLoadingState && profile == null) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 220,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: ColorManager.primary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: ColorManager.input,
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/patient.png",
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Text(
                                profile?.userName ?? 'User Name',
                                textAlign: TextAlign.center,
                                style: getBoldStyle(
                                  fontSize: 20,
                                  color: ColorManager.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Personal info.',
                          style: getBoldStyle(
                            fontSize: 14,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        ProfileOptionTile(
                          title: 'Basic Details',
                          subtitle: 'Name, Gender, DOB, Weight, Height',
                          onTap: () => showBasicDetailsBottomSheet(context),
                          iconPath: 'assets/svg_images/person.svg',
                        ),

                        ProfileOptionTile(
                          title: 'Medical Info.',
                          subtitle: 'Blood type, Allergies, chronic conditions',
                          onTap: () => showMedicalInfoBottomSheet(context),
                          iconPath: "assets/svg_images/love.svg",
                        ),

                        const SizedBox(height: 12),

                        Text(
                          'Language',
                          style: getBoldStyle(
                            fontSize: 14,
                            color: ColorManager.black,
                          ),
                        ),
                        const SizedBox(height: 12),

                        ProfileOptionTile(
                          title: 'English',
                          subtitle: null,
                          onTap: () {},
                          iconPath: "assets/svg_images/earth.svg",
                        ),

                        const SizedBox(height: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManager.lightGray,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: ColorManager.input),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Version',
                                    style: getRegularStyle(
                                      fontSize: 13,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                  Text(
                                    '1.0.0',
                                    style: getRegularStyle(
                                      fontSize: 13,
                                      color: ColorManager.gray,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 20, thickness: 0.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Terms and Privacy',
                                    style: getRegularStyle(
                                      fontSize: 13,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'View',
                                      style:
                                          getRegularStyle(
                                            fontSize: 13,
                                            color: ColorManager.blue600,
                                          ).copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: OutlinedButton.icon(
                            onPressed: () => _showLogoutDialog(context),
                            icon: const Icon(
                              Icons.logout_rounded,
                              color: ColorManager.error,
                              size: 20,
                            ),
                            label: Text(
                              'Logout',
                              style: getBoldStyle(
                                fontSize: 14,
                                color: ColorManager.error,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: ColorManager.lightRed,
                              side: const BorderSide(
                                color: ColorManager.lightRed,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Delete account',
                              style: getMediumStyle(
                                fontSize: 12,
                                color: ColorManager.error,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: getBoldStyle(fontSize: 16, color: ColorManager.black),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: getRegularStyle(fontSize: 14, color: ColorManager.darkGray),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: getMediumStyle(fontSize: 14, color: ColorManager.gray),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Logout',
              style: getBoldStyle(fontSize: 14, color: ColorManager.error),
            ),
          ),
        ],
      ),
    );
  }
}
