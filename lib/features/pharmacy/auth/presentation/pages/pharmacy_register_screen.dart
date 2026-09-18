import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/already_have_account.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_file_picker.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/core/widgets/terms_and_conditions.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/cubit/pharmacy_auth_cubit.dart';
import 'package:chefaa/features/pharmacy/auth/presentation/cubit/pharmacy_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PharmacyRegisterScreen extends StatelessWidget {
  final String role;
  const PharmacyRegisterScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PharmacyAuthCubit>();
    return Scaffold(
      backgroundColor: Color(0xffe1e3ec),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: cubit.registerFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pharmacy Register Title
                      const Text(
                        "Pharmacy Register",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // White Card Containing Form Inputs
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pharmacy Name
                            const Text(
                              "Pharmacy Name",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.NameController,
                              text: "Full Pharmacy legal name",
                              validator: Validators.businessNameValidator,
                            ),
                            const SizedBox(height: 12),

                            // Phone Number (Moved Up as per design)
                            const Text(
                              "Phone Number",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.phoneController,
                              text: "+20 xxxxxxxx",
                              prefixIcon:
                                  "assets/icons/Phone_icon_Inactive.svg",
                              validator: Validators.validatePhone,
                            ),
                            const SizedBox(height: 12),

                            // Work Email
                            const Text(
                              "Work Email",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.emailController,
                              text: "contact@pharmacy.com",
                              prefixIcon:
                                  "assets/icons/Email_icon_Inactive.svg",
                              validator: Validators.validateEmail,
                            ),
                            const SizedBox(height: 12),

                            // Password
                            const Text(
                              "Password",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.passwordController,
                              text: "Enter your password",
                              prefixIcon:
                                  "assets/icons/Password_icon_Inactive.svg",
                              validator: Validators.validatePassword,
                              isPass: true,
                            ),
                            const SizedBox(height: 12),

                            // Confirm Password
                            const Text(
                              "Confirm Password",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.confirmPasswordController,
                              text: "Re-enter your password",
                              prefixIcon:
                                  "assets/icons/Password_icon_Inactive.svg",
                              validator: (value) =>
                                  Validators.validateConfirmPassword(
                                    value,
                                    cubit.passwordController.text,
                                  ),
                              isPass: true,
                            ),
                            const SizedBox(height: 12),

                            // Commercial License Number
                            const Text(
                              "Commercial License Number",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.commNumber,
                              text: "e.g. LIC-676-78",
                              validator: Validators.validateLicense,
                            ),
                            const SizedBox(height: 12),

                            // Medical License Upload
                            const Text(
                              "Medical license Upload",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            BlocBuilder<PharmacyAuthCubit, PharmacyAuthState>(
                              builder: (context, state) {
                                return CustomFilePicker(
                                  selectedFile: cubit.membershipFile,
                                  label: "Upload your liecence",
                                  onFileSelected: (file) =>
                                      cubit.setMembershipFile(file),
                                  onFileRemoved: () =>
                                      cubit.removeMembershipFile(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Terms and Conditions (Outside the white card)
                      BlocBuilder<PharmacyAuthCubit, PharmacyAuthState>(
                        builder: (context, state) {
                          return TermsAndConditions(
                            value: cubit.isTermsAccepted,
                            onChanged: (val) => cubit.toggleTerms(val),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // Submit Button
                      BlocConsumer<PharmacyAuthCubit, PharmacyAuthState>(
                        listener: (context, state) {
                          if (state is RegisterPharmacySuccessState) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => CustomDialog(
                                title: "Verification in progress",
                                message:
                                    "Access to the Pharmacy features will be available once the verification is completed",
                                type: DialogType.verification,
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.login,
                                    (route) => false,
                                  );
                                },
                              ),
                            );
                          } else if (state is RegisterPharmacyErrorState) {
                            showDialog(
                              context: context,
                              builder: (_) => CustomDialog(
                                title: "Failed",
                                message: state.message,
                                type: DialogType.fail,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustemButton(
                            text: "Submit for Verification",
                            isLoading: state is RegisterPharmacyLoadingState,
                            onPressed: () => cubit.registerPharmacy(role: role),
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                      const AlreadyHaveAccount(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
