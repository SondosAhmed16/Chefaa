import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/facility/profile/data/model/profile_data.dart';
import 'package:chefaa/features/facility/profile/data/model/working_hours.dart';
import 'package:chefaa/features/facility/profile/presentation/cubit/lab_profile_cubit.dart';
import 'package:chefaa/features/facility/profile/presentation/cubit/lab_profile_state.dart';
import 'package:chefaa/features/facility/profile/presentation/widget/lab_profile_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LabProfileScreen extends StatelessWidget {
  const LabProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      body: BlocConsumer<LabProfileCubit, LabProfileState>(
        listener: (context, state) {
          if (state is LabProfileUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is LabProfileUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error.message),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LabProfileLoading || state is LabProfileUpdating) {
            return const Center(
              child: CircularProgressIndicator(color: ColorManager.primary),
            );
          }

          ProfileData? profile;
          if (state is LabProfileSuccess) {
            profile = state.response.profileData;
          } else if (state is LabProfileUpdateSuccess) {
            profile = state.response.profileData;
          }

          if (profile == null && state is! LabProfileError) {
            return const Center(child: Text('No Profile Data Available'));
          }

          if (state is LabProfileError) {
            return Center(
              child: Text(
                state.error.message,
                style: getMediumStyle(
                  color: ColorManager.error,
                  fontSize: FontSize.s14,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                if (profile != null) ...[
                  LabProfileHeaderWidget(
                    profile: profile,
                    onEditPressed: () {
                      _showEditProfileBottomSheet(context, profile!);
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        _buildLocationCard(profile),
                        const SizedBox(height: 16),
                        _buildCenterDetailsCard(profile),
                        const SizedBox(height: 16),
                        _buildSettingsCard(context, profile),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  void _showEditProfileBottomSheet(BuildContext context, ProfileData profile) {
    final profileCubit = context.read<LabProfileCubit>();

    final nameController = TextEditingController(text: profile.name ?? '');
    final phoneController = TextEditingController(
      text: profile.phoneNumber ?? '',
    );
    final commercialController = TextEditingController(
      text: profile.commercialRegisterNumber ?? '',
    );
    final directorController = TextEditingController(
      text: profile.medicalDirectorName ?? '',
    );
    final directorIdController = TextEditingController(
      text: profile.directorProfessionalId ?? '',
    );

    String selectedFacilityType = profile.facilityType ?? 'lab';
    int selectedOpenHour = profile.workingHours?.open ?? 8;
    int selectedCloseHour = profile.workingHours?.close ?? 22;

    List<String> selectedPaymentMethods = List<String>.from(
      profile.paymentMethods ?? ['Cash'],
    );

    final List<int> hoursList = List.generate(24, (index) => index + 1);
    final List<String> facilityTypes = ['lab', 'radiology center', 'both'];

    final List<String> availablePaymentMethods = ['Cash', 'Visa', 'Insurance'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorManager.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Center Profile',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Center Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 12),

                    DropdownButtonFormField<String>(
                      value: facilityTypes.contains(selectedFacilityType)
                          ? selectedFacilityType
                          : 'lab',
                      decoration: const InputDecoration(
                        labelText: 'Facility Type',
                      ),
                      items: facilityTypes.map((type) {
                        return DropdownMenuItem(
                          value: type,
                          child: Text(type.toUpperCase()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedFacilityType = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: hoursList.contains(selectedOpenHour)
                                ? selectedOpenHour
                                : 8,
                            decoration: const InputDecoration(
                              labelText: 'Open Hour',
                            ),
                            items: hoursList.map((hour) {
                              return DropdownMenuItem(
                                value: hour,
                                child: Text('$hour:00'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedOpenHour = value;
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            value: hoursList.contains(selectedCloseHour)
                                ? selectedCloseHour
                                : 22,
                            decoration: const InputDecoration(
                              labelText: 'Close Hour',
                            ),
                            items: hoursList.map((hour) {
                              return DropdownMenuItem(
                                value: hour,
                                child: Text('$hour:00'),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selectedCloseHour = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // عنوان طرق الدفع متعددة الاختيار
                    Text(
                      'Payment Methods',
                      style: getSemiBoldStyle(
                        color: ColorManager.black,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // توليد CheckboxListTile لكل طريقة دفع
                    ...availablePaymentMethods.map((method) {
                      final isSelected = selectedPaymentMethods.contains(
                        method,
                      );
                      return CheckboxListTile(
                        title: Text(method),
                        value: isSelected,
                        activeColor: ColorManager.primary,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked == true) {
                              if (!selectedPaymentMethods.contains(method)) {
                                selectedPaymentMethods.add(method);
                              }
                            } else {
                              // منع إزالة جميع الطرق بحيث تظل هناك طريقة واحدة على الأقل مختارة
                              if (selectedPaymentMethods.length > 1) {
                                selectedPaymentMethods.remove(method);
                              }
                            }
                          });
                        },
                      );
                    }),

                    const SizedBox(height: 12),
                    TextField(
                      controller: commercialController,
                      decoration: const InputDecoration(
                        labelText: 'Commercial Register Number',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: directorController,
                      decoration: const InputDecoration(
                        labelText: 'Medical Director Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: directorIdController,
                      decoration: const InputDecoration(
                        labelText: 'Director Professional ID',
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          profileCubit.updateProfile(
                            name: nameController.text.trim(),
                            phoneNumber: phoneController.text.trim(),
                            facilityType: selectedFacilityType,
                            workingHours: WorkingHours(
                              open: selectedOpenHour,
                              close: selectedCloseHour,
                            ),
                            paymentMethods:
                                selectedPaymentMethods, // إرسال القائمة المختارة كاملة
                            commercialRegisterNumber: commercialController.text
                                .trim(),
                            medicalDirectorName: directorController.text.trim(),
                            directorProfessionalId: directorIdController.text
                                .trim(),
                          );
                          Navigator.pop(bottomSheetContext);
                        },
                        child: Text(
                          'Save Changes',
                          style: getBoldStyle(
                            color: ColorManager.white,
                            fontSize: FontSize.s16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLocationCard(ProfileData profile) {
    final firstAddress = profile.addresses?.isNotEmpty == true
        ? profile.addresses!.first
        : null;
    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Location',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Open maps',
                    style: getMediumStyle(
                      color: ColorManager.primary,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${firstAddress?.addressText ?? ''}${firstAddress?.floor != null ? ', Floor ${firstAddress!.floor}' : ''}',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterDetailsCard(ProfileData profile) {
    final openTime = profile.workingHours?.open;
    final closeTime = profile.workingHours?.close;
    final workingHoursText = (openTime != null && closeTime != null)
        ? '$openTime AM - $closeTime PM'
        : 'N/A';

    final paymentMethods = profile.paymentMethods?.join(' · ') ?? 'N/A';

    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Center details',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16,
              ),
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Phone', profile.phoneNumber ?? 'N/A'),
            _buildDetailRow('Working hours', workingHoursText),
            _buildDetailRow('Services count', '${profile.servicesCount ?? 0}'),
            _buildDetailRow(
              'Facility type',
              profile.facilityType?.toUpperCase() ?? 'N/A',
            ),
            _buildDetailRow('Payment', paymentMethods),
            _buildDetailRow(
              'Commercial Reg.',
              profile.commercialRegisterNumber ?? 'N/A',
            ),
            if (profile.medicalDirectorName != null)
              _buildDetailRow('Medical Director', profile.medicalDirectorName!),
            if (profile.directorProfessionalId != null)
              _buildDetailRow('Director ID', profile.directorProfessionalId!),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getRegularStyle(
              color: ColorManager.gray,
              fontSize: FontSize.s14,
            ),
          ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: getSemiBoldStyle(
                color: ColorManager.primary,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, ProfileData profile) {
    return Card(
      color: ColorManager.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: FontSize.s16,
              ),
            ),
            const SizedBox(height: 12),
            _buildSwitchTile(
              title: 'Home sample collection',
              subtitle: 'Lab tests only',
              value: profile.settings?.homeSampleCollection ?? false,
              onChanged: (newValue) {
                context.read<LabProfileCubit>().updateProfile(
                  homeSampleCollection: newValue,
                );
              },
            ),
            _buildSwitchTile(
              title: 'AI recommendations',
              subtitle: 'Allow AI to route patients to you',
              value: profile.settings?.aiRecommendations ?? false,
              onChanged: (newValue) {
                context.read<LabProfileCubit>().updateProfile(
                  aiRecommendations: newValue,
                );
              },
            ),
            _buildSwitchTile(
              title: 'Insurance accepted',
              subtitle: 'Show insurance badge in search',
              value: profile.settings?.insuranceAccepted ?? false,
              onChanged: (newValue) {
                context.read<LabProfileCubit>().updateProfile(
                  insuranceAccepted: newValue,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: getSemiBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s14,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: getRegularStyle(
          color: ColorManager.gray,
          fontSize: FontSize.s12,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: ColorManager.primary,
      inactiveTrackColor: ColorManager.darkGray.withOpacity(0.3),
      inactiveThumbColor: ColorManager.darkGray,
      contentPadding: EdgeInsets.zero,
    );
  }
}
