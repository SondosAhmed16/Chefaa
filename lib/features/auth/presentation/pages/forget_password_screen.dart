import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),

              child: Form(
                key: cubit.forgetPasswordformKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: ColorManager.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),

                    SizedBox(height: 16),
                    Text(
                      'Forgot Your Password?',
                      style: getBoldStyle(
                        fontSize: 22,
                        color: ColorManager.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Enter your email or your phone number, we will send you confirmation code',
                      style: getRegularStyle(
                        fontSize: 14,
                        color: ColorManager.gray,
                      ),
                    ),
                    const SizedBox(height: 24),

                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) =>
                          current is ToggleTabState,

                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: ColorManager.lightGray,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => cubit.selectTab(0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cubit.selectedTabIndex == 0
                                          ? ColorManager.white
                                          : ColorManager.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: cubit.selectedTabIndex == 0
                                          ? [
                                              BoxShadow(
                                                color: ColorManager.black
                                                    .withOpacity(0.05),
                                                blurRadius: 4,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Email',
                                        style: getBoldStyle(
                                          fontSize: 14,
                                          color: cubit.selectedTabIndex == 0
                                              ? ColorManager.primary
                                              : ColorManager.gray,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => cubit.selectTab(1),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: cubit.selectedTabIndex == 1
                                          ? ColorManager.white
                                          : ColorManager.transparent,
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: cubit.selectedTabIndex == 1
                                          ? [
                                              BoxShadow(
                                                color: ColorManager.black
                                                    .withOpacity(0.05),
                                                blurRadius: 4,
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Phone',
                                        style: getBoldStyle(
                                          fontSize: 14,
                                          color: cubit.selectedTabIndex == 1
                                              ? ColorManager.primary
                                              : ColorManager.gray,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    BlocBuilder<AuthCubit, AuthState>(
                      buildWhen: (previous, current) =>
                          current is ToggleTabState,
                      builder: (context, state) {
                        final isEmail = cubit.selectedTabIndex == 0;
                        return TextFormField(
                          controller: isEmail
                              ? cubit.emailController
                              : cubit.phoneController,
                          keyboardType: isEmail
                              ? TextInputType.emailAddress
                              : TextInputType.phone,
                          style: getRegularStyle(
                            fontSize: 14,
                            color: ColorManager.black,
                          ),
                          decoration: InputDecoration(
                            hintText: isEmail
                                ? 'user@gmail.com'
                                : '+085281882151',
                            hintStyle: getRegularStyle(
                              fontSize: 14,
                              color: ColorManager.gray,
                            ),
                            prefixIcon: Icon(
                              isEmail
                                  ? Icons.email_outlined
                                  : Icons.phone_outlined,
                              color: ColorManager.primary,
                            ),
                            filled: true,
                            fillColor: ColorManager.lightGray,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: ColorManager.input,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: ColorManager.input,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: ColorManager.primary,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(
                                color: ColorManager.error,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return isEmail
                                  ? '*Invalid email'
                                  : '*Invalid phone number';
                            }
                            return null;
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 32),

                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is ForgetPasswordSuccessState) {
                          Navigator.pushNamed(
                            context,
                            Routes.verifyCode,
                            arguments: cubit,
                          );
                        } else if (state is ForgetPasswordErrorState) {
                          showDialog(
                            context: context,
                            builder: (_) => CustomDialog(
                              title: ' Failed',
                              message: state.message,
                              type: DialogType.fail,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustemButton(
                          text: 'Reset your password',
                          isLoading: state is ForgetPasswordISLoadingState,
                          onPressed: () {
                            cubit.forgetPass();
                          },
                        );
                      },
                    ),
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
