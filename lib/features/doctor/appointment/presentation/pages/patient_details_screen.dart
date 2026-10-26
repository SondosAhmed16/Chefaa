import 'package:chefaa/core/di/injection_container.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/font.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_appo_state.dart';
import 'package:chefaa/features/doctor/appointment/presentation/cubit/doctor_repo_cubit.dart';
import 'package:chefaa/features/doctor/appointment/presentation/pages/add_prescription_screen.dart';
import 'package:chefaa/features/doctor/appointment/presentation/pages/previous_prescription_screen.dart';
import 'package:flutter/material.dart';
import 'package:chefaa/features/doctor/appointment/data/model/doctor_appointment_model/datum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Datum appointment;

  const PatientDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final patient = appointment.patient;
    final user = patient?.userId;
    final addressText = patient?.address?.addressText ?? 'N/A';

    final isPaid =
        appointment.paymentStatus == 'paid-at-clinic' ||
        appointment.paymentStatus == 'paid-online';

    return Scaffold(
      backgroundColor: ColorManager.lightGray,
      appBar: AppBar(
        title: Text(
          'Patient Details',
          style: getBoldStyle(
            color: ColorManager.white,
            fontSize: FontSize.s18,
          ),
        ),
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildSectionTitle('Contact Information'),
                  const SizedBox(height: 8),
                  _buildCardContainer(
                    children: [
                      _buildInfoRow('Name', user?.name ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow('Phone', user?.phoneNumber ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow('Email', user?.email ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow('Address', addressText),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Personal Information'),
                  const SizedBox(height: 8),
                  _buildCardContainer(
                    children: [
                      _buildInfoRow('Age', patient?.age?.toString() ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow('Gender', patient?.gender ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow('Blood Type', patient?.bloodType ?? 'N/A'),
                      const Divider(height: 1, color: ColorManager.input),
                      _buildInfoRow(
                        'Weight',
                        patient?.weight != null ? '${patient!.weight}' : 'N/A',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildSectionTitle('Medical History'),
                  const SizedBox(height: 8),
                  _buildCardContainer(
                    children: [
                      _buildChipListRow(
                        title: 'Allergies',
                        items: patient?.allergies,
                        chipBgColor: ColorManager.sky50,
                        chipTextColor: ColorManager.blue600,
                      ),
                      const SizedBox(height: 12),
                      _buildChipListRow(
                        title: 'Chronic Conditions',
                        items: patient?.chronicConditions,
                        chipBgColor: ColorManager.amber50,
                        chipTextColor: ColorManager.amber600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            const SizedBox(height: 10),
            CustemButton(
              text: 'Add Prescription',
              isLoading: false,
              onPressed: () {
                final appointmentId = appointment.id;
                if (appointmentId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => getIt<DoctorRepoCubit>(),
                        child: AddPrescriptionScreen(
                          appointmentId: appointmentId,
                        ),
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment ID is missing!'),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.input,
                  foregroundColor: ColorManager.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  final appointmentId = appointment.id;
                  if (appointmentId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => getIt<DoctorRepoCubit>()
                            ..getPreviousPrescription(appoId: appointmentId),
                          child: PreviousPrescriptionScreen(
                            appointmentId: appointmentId,
                          ),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Appointment ID is missing!'),
                        backgroundColor: ColorManager.error,
                      ),
                    );
                  }
                },
                child: Text(
                  'Get Previous Prescription',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            if (!isPaid) ...[
              BlocConsumer<DoctorRepoCubit, DoctorAppoState>(
                listener: (context, state) {
                  if (state is MarkAppoPaiedSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.paiedAppointmentModel.message ??
                              'Marked as paid successfully',
                        ),
                        backgroundColor: ColorManager.lightGreen,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (state is MarkAppoPaiedError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.message),
                        backgroundColor: ColorManager.error,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is MarkAppoPaiedLoading;

                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.amber600,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              final appointmentId = appointment.id;
                              if (appointmentId != null) {
                                context.read<DoctorRepoCubit>().markAppoPaied(
                                  appoId: appointmentId,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Appointment ID is missing!'),
                                    backgroundColor: ColorManager.error,
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: ColorManager.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Mark as Paid',
                              style: getBoldStyle(
                                color: ColorManager.white,
                                fontSize: FontSize.s16,
                              ),
                            ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],

            BlocConsumer<DoctorRepoCubit, DoctorAppoState>(
              listener: (context, state) {
                if (state is CompleteAppoSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.completedAppointmentModel.message ??
                            'Appointment completed successfully',
                      ),
                      backgroundColor: ColorManager.lightGreen,
                    ),
                  );
                  Navigator.pop(context);
                } else if (state is CompleteAppoError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error.message),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is CompleteAppoLoading;

                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: isLoading
                        ? null
                        : () {
                            final appointmentId = appointment.id;
                            if (appointmentId != null) {
                              context.read<DoctorRepoCubit>().completeAppo(
                                appoId: appointmentId,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Appointment ID is missing!'),
                                  backgroundColor: ColorManager.error,
                                ),
                              );
                            }
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: ColorManager.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Text(
                            'Complete',
                            style: getBoldStyle(
                              color: ColorManager.white,
                              fontSize: FontSize.s16,
                            ),
                          ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: getBoldStyle(color: ColorManager.black, fontSize: FontSize.s18),
    );
  }

  Widget _buildCardContainer({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: getBoldStyle(color: ColorManager.black, fontSize: 15),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: getMediumStyle(
                color: ColorManager.gray,
                fontSize: FontSize.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipListRow({
    required String title,
    required List<String>? items,
    required Color chipBgColor,
    required Color chipTextColor,
  }) {
    final displayItems = (items == null || items.isEmpty) ? ['None'] : items;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: getBoldStyle(color: ColorManager.black, fontSize: 15),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: displayItems.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: chipBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: getBoldStyle(
                  color: chipTextColor,
                  fontSize: FontSize.s13,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
