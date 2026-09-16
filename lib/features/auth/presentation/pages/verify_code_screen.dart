import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_header.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: getBoldStyle(fontSize: 20, color: ColorManager.black),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.primary.withOpacity(0.5)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: ColorManager.primary, width: 2),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: ColorManager.error, width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomHeader(),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: cubit.verifyCodeFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: ColorManager.black,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Enter Verification Code",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 22,
                        ),
                      ),

                      const SizedBox(height: 8),

                      RichText(
                        text: TextSpan(
                          style: getRegularStyle(
                            fontSize: 14,
                            color: ColorManager.gray,
                          ),
                          children: [
                            TextSpan(
                              text: cubit.selectedTabIndex == 0
                                  ? 'Enter code that we have sent to your email '
                                  : 'Enter code that we have sent to your number ',
                            ),
                            TextSpan(
                              text: cubit.formattedIdentity,
                              style: getBoldStyle(
                                fontSize: 14,
                                color: ColorManager.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      Center(
                        child: Pinput(
                          length: 4,
                          controller: cubit.codeController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          errorPinTheme: errorPinTheme,
                          validator: (value) {
                            if (value == null || value.length < 4) {
                              return 'Please enter complete code';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 32),

                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is ResetCodeSuccessState) {
                            Navigator.pushNamed(context, Routes.resetPAss,arguments: cubit);
                          } else if (state is ResetCodeErrorState) {
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
                            text: "Verify Code",
                            onPressed: () => cubit.verifyCode(),
                            isLoading: state is ResetCodeISLoadingState,
                          );
                        },
                      ),
                      const SizedBox(height: 16),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Didn't receive the code? ",
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.gray,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cubit.forgetPass();
                              },
                              child: Text(
                                'Resend',
                                style:
                                    getBoldStyle(
                                      fontSize: 13,
                                      color: ColorManager.primary,
                                    ).copyWith(
                                      decoration: TextDecoration.underline,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
