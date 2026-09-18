import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/already_have_account.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/core/widgets/terms_and_conditions.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_cubit.dart';
import 'package:chefaa/features/patient/auth/presentation/cubit/patient_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientRegisterScreen extends StatelessWidget {
  final String role;
  const PatientRegisterScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PatientAuthCubit>();
    return Scaffold(
      backgroundColor: ColorManager.white,
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              controller: cubit.firstNameController,
                              text: "First Name",
                              prefixIcon: "assets/icons/User_icon_Inactive.svg",
                              validator: Validators.nameValidator,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CustomTextField(
                              controller: cubit.lastNameController,
                              text: "Last Name",
                              validator: Validators.nameValidator,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: cubit.emailController,
                        text: "Enter Your Email",
                        prefixIcon: "assets/icons/Email_icon_Inactive.svg",
                        validator: Validators.validateEmail,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: cubit.phoneController,
                        text: "Enter Your Phone",
                        prefixIcon: "assets/icons/Phone_icon_Inactive.svg",
                        validator: Validators.validatePhone,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: cubit.passwordController,
                        text: "Enter Your Password",
                        prefixIcon: "assets/icons/Password_icon_Inactive.svg",
                        validator: Validators.validatePassword,
                        isPass: true,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        controller: cubit.confirmPasswordController,
                        text: "Confirm Your Password",
                        prefixIcon: "assets/icons/Password_icon_Inactive.svg",
                        validator: (value) =>
                            Validators.validateConfirmPassword(
                              value,
                              cubit.passwordController.text,
                            ),
                        isPass: true,
                      ),

                      const SizedBox(height: 16),
                      BlocBuilder<PatientAuthCubit, PatientAuthState>(
                        builder: (context, state) {
                          return TermsAndConditions(
                            value: cubit.isTermsAccepted,
                            onChanged: (val) => cubit.toggleTerms(val),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocConsumer<PatientAuthCubit, PatientAuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (dialogContext) => CustomDialog(
                                title: "Success",
                                message:
                                    "Your account has been successfully registered",
                                type: DialogType.success,
                                onPressed: () {

                                  Navigator.of(dialogContext).pop();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.onboardingInfo,
                                    (route) => false,
                                  );
                                },
                              ),
                            );
                          } else if (state is RegisterErrorState) {
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
                            text: "Create account",
                            isLoading: state is RegisterLoadingState,
                            onPressed: () => cubit.registerPatient(role: role),
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
