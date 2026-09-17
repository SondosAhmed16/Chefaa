import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/services/share_services.dart';
import 'package:chefaa/features/onboarding/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  Future<void> _finishOnboarding() async {
    await ShareServices.saveBool("isFirstTime", false);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, Routes.forgetPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        onboardingData[index].image,
                        fit: BoxFit.cover,
                      ),
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              onboardingData[index].title,
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 22,
                              ),
                            ),

                            const SizedBox(height: 12),
                            Text(
                              onboardingData[index].description,
                              style: getRegularStyle(
                                fontSize: 13,
                                color: ColorManager.gray,
                              ),
                            ),
                            const Spacer(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: List.generate(
                                    onboardingData.length,
                                    (dotIndex) => AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.only(right: 8),
                                      height: 6,
                                      width: _currentIndex == dotIndex ? 18 : 6,
                                      decoration: BoxDecoration(
                                        color: _currentIndex == dotIndex
                                            ? ColorManager.primary
                                            : ColorManager.primary.withOpacity(
                                                0.3,
                                              ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    if (_currentIndex ==
                                        onboardingData.length - 1) {
                                      _finishOnboarding();
                                    } else {
                                      _pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  },

                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: ColorManager.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            Positioned(
              top: 16,
              right: 24,
              child: TextButton(
                onPressed: () => _finishOnboarding(),
                child: Text(
                  "skip",
                  style: getRegularStyle(
                    color: ColorManager.white.withOpacity(0.8),
                    fontSize: 14,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
