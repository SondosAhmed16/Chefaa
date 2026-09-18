import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/patient/onboarding/presentation/cubit/all_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/patient/onboarding/presentation/cubit/all_info_cubit.dart';

class OnboardingInfoScreen extends StatelessWidget {
  const OnboardingInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<AllInfoCubit, AllInfoState>(
          listener: (context, state) {
            if (state is AllInfoSuccessState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.response.message)));
            } else if (state is AllInfoErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error.message)));
            }
          },
          builder: (context, state) {
            final cubit = AllInfoCubit.get(context);

            return PageView(
              controller: cubit.pageController,
              onPageChanged: cubit.onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildBasicInfoPage(context, cubit, state),
                _buildChronicConditionsPage(context, cubit, state),
                _buildAllergiesPage(context, cubit, state),
                _buildLocationPage(context, cubit, state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBasicInfoPage(
    BuildContext context,
    AllInfoCubit cubit,
    AllInfoState state,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Gender",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: cubit.selectedGender,
                  decoration: _inputDecoration(),
                  items: ['Male', 'Female']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => cubit.selectedGender = val,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Date of birth",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cubit.dobController,
                  decoration: _inputDecoration(hint: "15/3/1995"),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Weight",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cubit.weightController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(hint: "85 Kg"),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Height",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cubit.heightController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration(hint: "170 cm"),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Blood Type",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: cubit.selectedBloodType,
                  decoration: _inputDecoration(),
                  items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) => cubit.selectedBloodType = val,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          CustemButton(
            text: "Continue",
            isLoading: false,
            onPressed: () => cubit.nextPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildChronicConditionsPage(
    BuildContext context,
    AllInfoCubit cubit,
    AllInfoState state,
  ) {
    final conditions = [
      'Diabetes',
      'Hypertension',
      'Heart Disease',
      'Asthma',
      'Kidney Disease',
      'Thyroid Disorders',
      'High Cholesterol',
      'Arthritis',
      'Other',
      'None',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Do you have any\nchronic conditions?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: conditions.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  itemBuilder: (context, index) {
                    final item = conditions[index];
                    final isSelected = cubit.selectedChronicConditions.contains(
                      item,
                    );
                    return InkWell(
                      onTap: () => cubit.toggleChronicCondition(item),
                      child: Container(
                        color: isSelected
                            ? const Color(0xFFD9D9D9)
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (cubit.selectedChronicConditions.contains('Other')) ...[
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextField(
                controller: cubit.otherChronicController,
                decoration: _inputDecoration(
                  hint: "Enter your chronic conditions",
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          CustemButton(
            text: "Continue",
            isLoading: false,
            onPressed: () => cubit.nextPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergiesPage(
    BuildContext context,
    AllInfoCubit cubit,
    AllInfoState state,
  ) {
    final allergies = [
      'Dust',
      'Pollen',
      'Food Allergy',
      'Nuts Allergy',
      'Lactose Intolerance',
      'Gluten Sensitivity',
      'Medication Allergy',
      'Sun Allergy',
      'Insect Allergy',
      'None',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Do you have\nany allergies?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: allergies.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  itemBuilder: (context, index) {
                    final item = allergies[index];
                    final isSelected = cubit.selectedAllergies.contains(item);
                    return InkWell(
                      onTap: () => cubit.toggleAllergy(item),
                      child: Container(
                        color: isSelected
                            ? const Color(0xFFD9D9D9)
                            : Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        child: Text(
                          item,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          if (cubit.selectedAllergies.contains('Medication Allergy')) ...[
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: TextField(
                controller: cubit.otherAllergyController,
                decoration: _inputDecoration(
                  hint: "Enter the name of medicine",
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          CustemButton(
            text: "Continue",
            isLoading: false,
            onPressed: () => cubit.nextPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationPage(
    BuildContext context,
    AllInfoCubit cubit,
    AllInfoState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 80, color: ColorManager.primary),
          const SizedBox(height: 20),
          const Text(
            "Enable Location Access",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "We use your location to provide accurate health recommendations and nearby services.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          const SizedBox(height: 40),
          CustemButton(
            text: "Allow Location",
            isLoading: state is AllInfoLoadingState,
            onPressed: () => cubit.submitAllInfo(),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => cubit.submitAllInfo(),
            child: const Text(
              "Not Now",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF8F9FA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFEFEFEF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: ColorManager.primary),
      ),
    );
  }
}
