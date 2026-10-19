import 'dart:io';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_cubit.dart';
import 'package:chefaa/features/doctor/profile/presentation/cubit/doctor_profile_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _ageController;
  late TextEditingController _experienceController;
  late TextEditingController _aboutController;
  late TextEditingController _contactController;
  late TextEditingController _priceController;
  late TextEditingController _degreeController;
  late TextEditingController _prePayNumberController;

  List<String> _degrees = [];
  List<String> _prePaymentNumbers = [];
  String? _selectedPaymentOption;
  String? _selectedGender;
  String? _selectedImagePath;

  bool _isDataInitialized = false;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController();
    _experienceController = TextEditingController();
    _aboutController = TextEditingController();
    _contactController = TextEditingController();
    _priceController = TextEditingController();
    _degreeController = TextEditingController();
    _prePayNumberController = TextEditingController();

    context.read<DoctorProfileCubit>().getDoctorProfile();
  }

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

  void _initControllers(dynamic doctorData) {
    if (_isDataInitialized) return;
    _ageController.text = doctorData.age?.toString() ?? '';
    _experienceController.text = doctorData.yearsOfExperience?.toString() ?? '';
    _aboutController.text = doctorData.about ?? '';
    _contactController.text = doctorData.contactNumber ?? '';
    _priceController.text =
        doctorData.clinicConsultationPrice?.toString() ?? '';
    _selectedGender = doctorData.gender;
    _selectedPaymentOption = doctorData.paymentOption;
    _degrees = List<String>.from(doctorData.degrees ?? []);
    _prePaymentNumbers = List<String>.from(doctorData.prePaymentNumbers ?? []);
    _isDataInitialized = true;
  }

  Future<void> _pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      String imagePath = result.files.single.path!;

      context.read<DoctorProfileCubit>().updateDoctorProfile(
        age: int.tryParse(_ageController.text) ?? 0,
        yearsOfExperience: int.tryParse(_experienceController.text) ?? 0,
        gender: _selectedGender ?? 'male',
        paymentOption: _selectedPaymentOption ?? 'in_clinic',
        prePaymentNumbers: _prePaymentNumbers,
        degrees: _degrees,
        clinicConsultationPrice: num.tryParse(_priceController.text) ?? 0,
        contactNumber: _contactController.text,
        about: _aboutController.text,
        imageUrl: imagePath,
      );
    }
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Change Profile Photo',
                style: getBoldStyle(color: ColorManager.black, fontSize: 18),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: ColorManager.primary,
                ),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: ColorManager.primary,
                ),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Doctor Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: BlocConsumer<DoctorProfileCubit, DoctorProfileState>(
        listener: (context, state) {
          if (state is UpdateDoctorProfileSuccess) {
            setState(() {
              _isEditing = false;
              _isDataInitialized = false;
              _selectedImagePath = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.profile.message ?? 'Profile updated successfully!',
                ),
                backgroundColor: Colors.green,
              ),
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
          if (state is DoctorProfileLoading ||
              state is UpdateDoctorProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          dynamic doctorData;
          if (state is UpdateDoctorProfileSuccess) {
            doctorData = state.profile.doctor;
          } else if (state is DoctorProfileSuccess) {
            doctorData = state.profile;
          }

          if (doctorData == null && state is DoctorProfileError) {
            return Center(
              child: Text(
                state.error.message,
                style: getMediumStyle(color: ColorManager.error, fontSize: 14),
              ),
            );
          }

          if (doctorData == null) {
            return const Center(child: Text('No Profile Data Available'));
          }

          _initControllers(doctorData);

          final String name = doctorData.name ?? 'Doctor Name';
          final String specialization =
              doctorData.specialization ?? 'Specialization';
          final String imageUrl = doctorData.image ?? '';
          final int clinicsCount = doctorData.clinics?.length ?? 0;
          final double rating = (doctorData.rating ?? 0.0).toDouble();
          final int yearsOfExperience = doctorData.yearsOfExperience ?? 0;
          final num consultationPrice = doctorData.clinicConsultationPrice ?? 0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => _showImagePickerBottomSheet(context),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: ColorManager.primary.withOpacity(
                            0.1,
                          ),
                          backgroundImage: _selectedImagePath != null
                              ? FileImage(File(_selectedImagePath!))
                                    as ImageProvider
                              : (imageUrl.isNotEmpty
                                    ? NetworkImage(imageUrl)
                                    : null),
                          child:
                              (_selectedImagePath == null && imageUrl.isEmpty)
                              ? const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: ColorManager.primary,
                                )
                              : null,
                        ),
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorManager.primary,
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    name,
                    style: getBoldStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialization,
                    style: getMediumStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      _buildStatCard(
                        'Clinics',
                        '$clinicsCount',
                        Icons.local_hospital,
                      ),
                      _buildStatCard(
                        'Rating',
                        '★ ${rating.toStringAsFixed(1)}',
                        Icons.star,
                      ),
                      _buildStatCard(
                        'Exp.',
                        '$yearsOfExperience Yrs',
                        Icons.work,
                      ),
                      _buildStatCard(
                        'Price',
                        '$consultationPrice EGP',
                        Icons.payments,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  if (_isEditing)
                    _buildEditForm(context)
                  else
                    _buildProfileDetailsView(doctorData),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileDetailsView(dynamic doctorData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('About Doctor'),
        _buildCardContainer(
          child: Text(
            doctorData.about ?? 'No description added.',
            style: getRegularStyle(color: Colors.black87, fontSize: 14),
          ),
        ),
        const SizedBox(height: 16),

        _buildSectionTitle('Degrees & Qualifications'),
        if (_degrees.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _degrees
                .map(
                  (degree) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: ColorManager.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      degree,
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        else
          _buildCardContainer(
            child: Text(
              'No degrees added.',
              style: getRegularStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        const SizedBox(height: 16),

        _buildSectionTitle('Doctor Information'),
        _buildCardContainer(
          child: Column(
            children: [
              _buildInfoRow(Icons.email, 'Email', doctorData.email ?? 'N/A'),
              const Divider(),
              _buildInfoRow(
                Icons.phone,
                'Contact Number',
                doctorData.contactNumber ?? 'N/A',
              ),
              const Divider(),
              _buildInfoRow(
                Icons.cake,
                'Age',
                doctorData.age != null ? '${doctorData.age} Years' : 'N/A',
              ),
              const Divider(),
              _buildInfoRow(
                Icons.person_outline,
                'Gender',
                doctorData.gender ?? 'N/A',
              ),
              const Divider(),
              _buildInfoRow(
                Icons.payment,
                'Payment Option',
                doctorData.paymentOption ?? 'N/A',
              ),
              if ((doctorData.paymentOption == 'pre_payment' ||
                      doctorData.paymentOption == 'both') &&
                  _prePaymentNumbers.isNotEmpty) ...[
                const Divider(),
                _buildInfoRow(
                  Icons.phone_android,
                  'Pre-Payment Numbers',
                  _prePaymentNumbers.join(', '),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditForm(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: _ageController,
          text: 'Age',
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter age' : null,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _experienceController,
          text: 'Years of Experience',
          keyboardType: TextInputType.number,
          validator: (value) =>
              value == null || value.isEmpty ? 'Enter experience' : null,
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value: ['male', 'female'].contains(_selectedGender)
              ? _selectedGender
              : null,
          decoration: const InputDecoration(
            labelText: 'Gender',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'male', child: Text('Male')),
            DropdownMenuItem(value: 'female', child: Text('Female')),
          ],
          onChanged: (val) => setState(() => _selectedGender = val),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          value:
              [
                'in_clinic',
                'pre_payment',
                'both',
              ].contains(_selectedPaymentOption)
              ? _selectedPaymentOption
              : null,
          decoration: const InputDecoration(
            labelText: 'Payment Option',
            border: OutlineInputBorder(),
          ),
          items: const [
            DropdownMenuItem(value: 'in_clinic', child: Text('In Clinic')),
            DropdownMenuItem(value: 'pre_payment', child: Text('Pre Payment')),
            DropdownMenuItem(value: 'both', child: Text('Both')),
          ],
          onChanged: (val) => setState(() => _selectedPaymentOption = val),
        ),
        const SizedBox(height: 12),

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
                      _prePaymentNumbers.add(_prePayNumberController.text);
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
                  (num) => Chip(
                    label: Text(num),
                    onDeleted: () =>
                        setState(() => _prePaymentNumbers.remove(num)),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 12),
        ],

        // Degrees Field
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
                (deg) => Chip(
                  label: Text(deg),
                  onDeleted: () => setState(() => _degrees.remove(deg)),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),

        CustomTextField(
          controller: _priceController,
          text: 'Consultation Price',
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        CustomTextField(
          controller: _contactController,
          text: 'Contact Number',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        CustomTextField(controller: _aboutController, text: 'About'),
        const SizedBox(height: 20),

        CustemButton(
          text: 'Save Changes',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<DoctorProfileCubit>().updateDoctorProfile(
                age: int.parse(_ageController.text),
                yearsOfExperience: int.parse(_experienceController.text),
                gender: _selectedGender ?? 'male',
                paymentOption: _selectedPaymentOption ?? 'in_clinic',
                prePaymentNumbers: _prePaymentNumbers,
                degrees: _degrees,
                clinicConsultationPrice: num.parse(_priceController.text),
                contactNumber: _contactController.text,
                about: _aboutController.text,
                imageUrl: _selectedImagePath,
              );
            }
          },
          isLoading: false,
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 22, color: ColorManager.primary),
            const SizedBox(height: 6),
            Text(
              value,
              style: getBoldStyle(color: Colors.black, fontSize: 13),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: getRegularStyle(color: Colors.grey, fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: getBoldStyle(color: Colors.black, fontSize: 16),
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: ColorManager.primary),
          const SizedBox(width: 10),
          Text(
            '$title: ',
            style: getBoldStyle(color: Colors.black, fontSize: 13),
          ),
          Expanded(
            child: Text(
              value,
              style: getRegularStyle(color: Colors.grey.shade700, fontSize: 13),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
