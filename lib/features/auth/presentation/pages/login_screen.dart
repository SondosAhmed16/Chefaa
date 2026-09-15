import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/utils/validator.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chefaa/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              showDialog(
                context: context,
                builder: (_) => CustomDialog(
                  title: "Yeay! Welcome Back",
                  message: "Once again you login successfully into Chefaa app",
                  type: DialogType.success,
                  onPressed: () {},
                ),
              );
            } else if (state is LoginErrorState) {
              showDialog(
                context: context,
                builder: (_) => CustomDialog(
                  title: 'Login Failed',
                  message: state.message,
                  type: DialogType.fail,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),

                    Image.asset(
                      'assets/images/login_logo.png',
                      height: 80,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 50),

                    CustomTextField(
                      controller: cubit.identityController,
                      text: "Enter Your Email or Phone",
                      prefixIcon: "assets/icons/Email_icon_Inactive.svg",
                    ),

                    SizedBox(height: 20),

                    CustomTextField(
                      controller: cubit.passwordController,
                      text: "Enter your PAssword",
                      prefixIcon: "assets/icons/Password_icon_Inactive.svg",
                      validator: Validators.validateLoginPassword,
                      isPass: true,
                    ),
                    SizedBox(height: 8),

                    // Forgot Password Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Handle Forgot Password
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'Forgot Password?',
                          style: getMediumStyle(
                            color: ColorManager.primary,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
                        ),
                        onPressed: state is LoginIsLooadingState
                            ? null
                            : () {
                                if (cubit.formKey.currentState!.validate()) {
                                  cubit.login();
                                }
                              },
                        child: state is LoginIsLooadingState
                            ? SizedBox(
                                height: 22,
                                width: 22,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Login',
                                style: getBoldStyle(
                                  color: ColorManager.white,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Social Media Buttons
                    _buildSocialButton(
                      text: 'Sign in with Google',
                      iconPath: 'assets/svg_images/Google.svg',
                      onTap: () {},
                    ),

                    SizedBox(height: 12),

                    _buildSocialButton(
                      text: 'Sign in with Apple',
                      iconPath: 'assets/svg_images/bi_apple.svg',
                      onTap: () {},
                    ),

                    SizedBox(height: 30),

                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Sign Up Screen
                          },
                          child: Text(
                            'Sign Up',
                            style: getBoldStyle(
                              color: ColorManager.primary,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 20,
              width: 20,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.g_mobiledata, size: 24),
            ),
            SizedBox(width: 12),
            Text(
              text,
              style: getMediumStyle(color: ColorManager.black, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
