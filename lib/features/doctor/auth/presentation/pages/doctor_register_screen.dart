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
import 'package:chefaa/features/doctor/auth/presentation/cubit/doctor_auth_cubit.dart';
import 'package:chefaa/features/doctor/auth/presentation/cubit/doctor_auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DoctorRegisterScreen extends StatelessWidget {
  final String role;
  const DoctorRegisterScreen({super.key, required this.role});

  static const List<String> specializations = [
    'General',
    'Neurology',
    'Cardiology',
    'Ophthalmology',
    'Gynecology & Obstetrics',
    'Internal Medicine',
    'Pulmonology',
    'Urology',
    'Dermatology',
    'Orthopedics',
    'Endocrinology',
    'ENT',
    'Nutrition',
    'Dentistry',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorAuthCubit>();
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
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        value: cubit.selectedSpecialization,
                        decoration: InputDecoration(
                          hintText: "Select your specialization",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              "assets/svg_images/medical.svg",
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        items: specializations.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          cubit.selectedSpecialization = val;
                        },
                        validator: (val) => val == null
                            ? "Please select a specialization"
                            : null,
                      ),
                      const SizedBox(height: 12),

                      BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
                        builder: (context, state) {
                          return CustomFilePicker(
                            selectedFile: cubit.membershipFile,
                            label: "Upload your Membership Card",
                            onFileSelected: (file) =>
                                cubit.setMembershipFile(file),
                            onFileRemoved: () => cubit.removeMembershipFile(),
                          );
                        },
                      ),

                      const SizedBox(height: 16),

                      BlocBuilder<DoctorAuthCubit, DoctorAuthState>(
                        builder: (context, state) {
                          return TermsAndConditions(
                            value: cubit.isTermsAccepted,
                            onChanged: (val) => cubit.toggleTerms(val),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      BlocConsumer<DoctorAuthCubit, DoctorAuthState>(
                        listener: (context, state) {
                          if (state is RegisterOctorSuccessState) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => CustomDialog(
                                title: "Verification in progress",
                                message:
                                    "Access to the doctor features will be available once the verification is completed",
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
                          } else if (state is RegisterDoctorErrorState) {
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
                            isLoading: state is RegisterDoctorLoadingState,
                            onPressed: () => cubit.registerDoctor(role: role),
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
