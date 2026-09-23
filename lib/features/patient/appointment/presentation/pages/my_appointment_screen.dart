import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/appointment/data/model/datum.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_state.dart';
import 'package:chefaa/features/patient/appointment/presentation/pages/reschedual_screen.dart';
import 'package:chefaa/features/patient/appointment/presentation/widget/appointment_card.dart';
import 'package:chefaa/features/patient/search/data/model/break.dart'
    as search_break;
import 'package:chefaa/features/patient/search/data/model/day.dart'
    as search_day;
import 'package:chefaa/features/patient/search/data/model/default_schedule.dart'
    as search_schedule;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chefaa/features/patient/search/data/model/clinic.dart'
    as search_clinic;

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({super.key});

  @override
  State<MyAppointmentScreen> createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 50,
              bottom: 24,
              left: 16,
              right: 16,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: ColorManager.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text(
                  "My Appointments",
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ],
            ),
          ),

          Expanded(
            child: BlocConsumer<AppointmentCubit, AppointmentState>(
              listener: (context, state) {
                if (state is AppointmentError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                } else if (state is CancelSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Appointment cancelled successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<AppointmentCubit>().fetchAppointments();
                } else if (state is CancelErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: ColorManager.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AppointmentLoading ||
                    state is CancelLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                  );
                } else if (state is AppointmentSuccess) {
                  final appointments = state.appointments;
                  if (appointments.isEmpty) {
                    return Center(
                      child: Text(
                        "No Appointment Yet",
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 22,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 12, bottom: 24),
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      return AppointmentCard(
                        appointment: appointments[index],
                        onDecline: () =>
                            _handleDecline(context, appointments[index].id),
                        onReschedule: () =>
                            _handleReschedule(context, appointments[index]),
                      );
                    },
                  );
                } else if (state is AppointmentError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.message,
                          style: getBoldStyle(
                            color: ColorManager.error,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<AppointmentCubit>()
                                .fetchAppointments();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void _handleDecline(BuildContext context, String? appointmentId) {
  if (appointmentId == null) return;
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Cancel Appointment'),
      content: const Text('Are you sure you want to cancel this appointment?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.read<AppointmentCubit>().cancelAppo(
                  appointmentId: appointmentId,
                );
              }
            });
          },
          child: const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  );
}

void _handleReschedule(BuildContext context, Datum appointment) async {
  final clinicData = appointment.clinic;

  print("DEBUG defaultSchedule: ${appointment.clinic?.defaultSchedule}");
  search_schedule.DefaultSchedule? mappedSchedule;

  final scheduleSource = clinicData?.defaultSchedule;

  if (scheduleSource != null) {
    mappedSchedule = search_schedule.DefaultSchedule(
      slotDuration: scheduleSource.slotDuration ?? 30,
      dailyCapacity: scheduleSource.dailyCapacity,
      patientsPerSlot: scheduleSource.patientsPerSlot,
      days: scheduleSource.days?.map((day) {
        return search_day.Day(
          day: day.day,
          isActive: day.isActive,
          open: day.open,
          close: day.close,
          slotDuration: day.slotDuration,
          dailyCapacity: day.dailyCapacity,
          patientsPerSlot: day.patientsPerSlot,
          isDayLocked: day.isDayLocked,
          isBookingLocked: day.isBookingLocked,
          breaks: day.breaks?.map((b) {
            return search_break.Break(
              start: b.start,
              end: b.end,
              label: b.label,
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  final search_clinic.Clinic clinic = search_clinic.Clinic(
    id: clinicData?.id,
    name: clinicData?.name,
    address: clinicData?.address,
    price: clinicData?.price,
    defaultSchedule: mappedSchedule,
  );

  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: context.read<AppointmentCubit>(),
        child: ReschedualScreen(appointment: appointment, clinic: clinic),
      ),
    ),
  );

  if (result == true && context.mounted) {
    context.read<AppointmentCubit>().fetchAppointments();
  }
}
