class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnboardingModel> onboardingData = [
  OnboardingModel(
    image: 'assets/images/onboarding_1.png',
    title: 'Stay on Top of Your Health',
    description: 'Your Health, Our Priority',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding_2.png',
    title: 'Your Doctor is Always Within Reach',
    description: 'Access medical guidance anytime without complications',
  ),
  OnboardingModel(
    image: 'assets/images/onboarding_3.png',
    title: 'Your health is Always Our Priority',
    description: 'Access your medical info quickly and securely with Chefaa.',
  ),
];
