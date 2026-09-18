import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/already_have_account.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_file_picker.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/core/widgets/terms_and_conditions.dart';
import 'package:chefaa/features/facility/auth/presentation/cubit/facility_auth_cubit.dart';
import 'package:chefaa/features/facility/auth/presentation/cubit/facility_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FacilityRegisterScreen extends StatelessWidget {
  final String role;
  const FacilityRegisterScreen({super.key, required this.role});

  static const List<String> facilityType = ['lab', 'radiology center', 'both'];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FacilityAuthCubit>();
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
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              value: cubit.selectedFacility,
                              decoration: InputDecoration(
                                hintText: "Choose lab or radiology",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),

                              items: facilityType.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),

                              onChanged: (val) {
                                cubit.selectedFacility = val;
                              },
                              validator: (val) => val == null
                                  ? "Please select a specialization"
                                  : null,
                            ),
                            const SizedBox(height: 12),

                            const Text(
                              "Facility Name",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.nameController,
                              text: "e.g.Alpha Lab/Scan",
                              validator: Validators.businessNameValidator,
                            ),
                            const SizedBox(height: 12),

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
                              text: "contact@facility.com",
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

                            const Text(
                              "Medical license Upload",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            BlocBuilder<FacilityAuthCubit, FacilityAuthState>(
                              builder: (context, state) {
                                return CustomFilePicker(
                                  selectedFile: cubit.memberShip,
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

                      const SizedBox(height: 50),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/Hospitalist.png",
                                  width: 30,
                                ),

                                const SizedBox(width: 5),
                                Text(
                                  "Medical LeaderShip",
                                  style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Medical Director Name",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.directorName,
                              text: "Doctor Full Name",
                              validator: Validators.businessNameValidator,
                            ),
                            const SizedBox(height: 12),

                            const Text(
                              "Director Professional ID",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            CustomTextField(
                              controller: cubit.directorId,
                              text: "ID Number",
                              validator: Validators.validateLicense,
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<FacilityAuthCubit, FacilityAuthState>(
                        builder: (context, state) {
                          return TermsAndConditions(
                            value: cubit.isTermsAccepted,
                            onChanged: (val) => cubit.toggleTerms(val),
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      BlocConsumer<FacilityAuthCubit, FacilityAuthState>(
                        listener: (context, state) {
                          if (state is AuthFacilitySuccessState) {
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
                          } else if (state is AuthFacilityErrorState) {
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
                            isLoading: state is AuthFacilityLoadingState,
                            onPressed: () => cubit.registerfacility(role: role),
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
