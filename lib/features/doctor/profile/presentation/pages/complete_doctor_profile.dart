import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/routes/app_router.dart';
import 'package:chefaa/core/services/share_services.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_cubit.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_state.dart';

class CompleteDoctorProfile extends StatefulWidget {
  const CompleteDoctorProfile({super.key});

  @override
  State<CompleteDoctorProfile> createState() => _CompleteDoctorProfileState();
}

class _CompleteDoctorProfileState extends State<CompleteDoctorProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _degreeController = TextEditingController();
  final List<String> _degrees = [];

  final TextEditingController _prePayNumberController = TextEditingController();
  final List<String> _prePaymentNumbers = [];

  String? _selectedPaymentOption;
  String? _selectedGender;

  @override
  void dispose() {
    _ageController.dispose();
    _experienceController.dispose();
    _aboutController.dispose();
    _contactController.dispose();
    _priceController.dispose();
    _degreeController.dispose();
    _prePayNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        centerTitle: true,
      ),
      body: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
        listener: (context, state) async {
          if (state is UpdateDoctorProfileSuccess) {
            await ShareServices.saveBool('isProfileCompleted', true);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.profile.message ?? 'Profile updated successfully',
                ),
              ),
            );

            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.getDoctorProfile,
              (route) => false,
            );
          } else if (state is UpdateDoctorProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          bool isLoading = state is UpdateDoctorProfileLoading;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  CustomTextField(
                    controller: _ageController,
                    text: 'Age',
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter your age'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _experienceController,
                    text: 'Years of Experience',
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter years of experience'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'male', child: Text('Male')),
                      DropdownMenuItem(value: 'female', child: Text('Female')),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedGender = value),
                    validator: (value) =>
                        value == null ? 'Please select gender' : null,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value:
                        [
                          'in_clinic',
                          'pre_payment',
                          'both',
                        ].contains(_selectedPaymentOption)
                        ? _selectedPaymentOption
                        : null, // تجنب الكراش في حال كانت القيمة غير متطابقة
                    decoration: const InputDecoration(
                      labelText: 'Payment Option',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'in_clinic',
                        child: Text('In Clinic'),
                      ),
                      DropdownMenuItem(
                        value: 'pre_payment',
                        child: Text('Pre Payment'),
                      ),
                      DropdownMenuItem(value: 'both', child: Text('Both')),
                    ],
                    onChanged: (value) =>
                        setState(() => _selectedPaymentOption = value),
                    validator: (value) =>
                        value == null ? 'Please select payment option' : null,
                  ),
                  const SizedBox(height: 16),

                  if (_selectedPaymentOption == 'pre_payment' ||
                      _selectedPaymentOption == 'both') ...[
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: _prePayNumberController,
                            text: 'Add Pre-Payment Number',
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (_prePayNumberController.text.isNotEmpty) {
                              setState(() {
                                _prePaymentNumbers.add(
                                  _prePayNumberController.text,
                                );
                                _prePayNumberController.clear();
                              });
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: _prePaymentNumbers
                          .map(
                            (number) => Chip(
                              label: Text(number),
                              onDeleted: () => setState(
                                () => _prePaymentNumbers.remove(number),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Degrees Section
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _degreeController,
                          text: 'Add Degree / Certificate',
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_degreeController.text.isNotEmpty) {
                            setState(() {
                              _degrees.add(_degreeController.text);
                              _degreeController.clear();
                            });
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _degrees
                        .map(
                          (degree) => Chip(
                            label: Text(degree),
                            onDeleted: () =>
                                setState(() => _degrees.remove(degree)),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _priceController,
                    text: 'Clinic Consultation Price',
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter consultation price'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _contactController,
                    text: 'Contact Number',
                    keyboardType: TextInputType.phone,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please enter contact number'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: _aboutController,
                    text: 'About',
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please write something about yourself'
                        : null,
                  ),
                  const SizedBox(height: 24),

                  CustemButton(
                    text: 'Save & Continue',
                    isLoading: isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<DoctorProfileCubit>().updateDoctorProfile(
                          age: int.parse(_ageController.text),
                          yearsOfExperience: int.parse(
                            _experienceController.text,
                          ),
                          gender: _selectedGender!,
                          paymentOption: _selectedPaymentOption!,
                          prePaymentNumbers: _prePaymentNumbers,
                          degrees: _degrees,
                          clinicConsultationPrice: num.parse(
                            _priceController.text,
                          ),
                          contactNumber: _contactController.text,
                          about: _aboutController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
