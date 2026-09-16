import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              Navigator.pushNamed(context, Routes.login);
            } else if (state is ResetPasswordErrorState) {
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
            return SingleChildScrollView(
              child: Column(
                children: [
                  const CustomHeader(),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: cubit.resetPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Create New Password",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 22,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Create Your new password to login",
                            style: getRegularStyle(
                              fontSize: 14,
                              color: ColorManager.gray,
                            ),
                          ),

                          const SizedBox(height: 32),

                          CustomTextField(
                            controller: cubit.newPasswordController,
                            text: "Enter new password",
                            validator: Validators.validatePassword,
                            prefixIcon:
                                "assets/icons/Password_icon_Inactive.svg",
                            isPass: true,
                          ),

                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: cubit.confirmPasswordController,
                            text: "Confirm password",
                            validator: (value) =>
                                Validators.validateConfirmPassword(
                                  value,
                                  cubit.newPasswordController.text,
                                ),
                            prefixIcon:
                                "assets/icons/Password_icon_Inactive.svg",
                            isPass: true,
                          ),

                          const SizedBox(height: 24),
                          CustemButton(
                            text: "reset password",
                            onPressed: () => cubit.resetPassword(),
                            isLoading: state is ResetPasswordISLoadingState,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
