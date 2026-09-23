import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/appointment/data/model/datum.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_cubit.dart';
import 'package:chefaa/features/patient/appointment/presentation/cubit/appointment_state.dart';
import 'package:chefaa/features/patient/search/data/model/clinic.dart';
import 'package:chefaa/features/patient/search/data/model/day.dart';
import 'package:chefaa/features/patient/search/data/model/schedual_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReschedualScreen extends StatefulWidget {
  final Datum appointment;
  final Clinic clinic;

  const ReschedualScreen({
    super.key,
    required this.clinic,
    required this.appointment,
  });

  String getInitials(String? name) {
    if (name == null || name.trim().isEmpty) return "DR";
    List<String> names = name.trim().split(" ");
    if (names.length >= 2) {
      return "${names[0][0]}${names[1][0]}".toUpperCase();
    }
    return names[0][0].toUpperCase();
  }

  @override
  State<ReschedualScreen> createState() => _ReschedualScreenState();
}

class _ReschedualScreenState extends State<ReschedualScreen> {
  List<Day> daysList = [];
  Day? selectedDay;

  List<String> availableSlots = [];
  String? selectedSlot;

  @override
  void initState() {
    super.initState();
    _initScheduleData();
  }

  void _initScheduleData() {
    final days = widget.clinic.defaultSchedule?.days ?? [];
    print("DEBUG: Days count = ${days.length}");

    setState(() {
      daysList = days;
      for (var day in days) {
        final available = SchedualAdapter.isDayAvailable(day);
        print(
          "DEBUG: Day ${day.day} -> isActive: ${day.isActive}, isLocked: ${day.isDayLocked}, isBookingLocked: ${day.isBookingLocked}, available: $available",
        );

        if (available) {
          _selectDay(day);
          break;
        }
      }
    });
  }

  void _selectDay(Day day) {
    final slotDuration = widget.clinic.defaultSchedule?.slotDuration ?? 30;
    setState(() {
      selectedDay = day;
      selectedSlot = null;
      availableSlots = SchedualAdapter.generateSlotsForDay(day, slotDuration);
    });
  }

  void _submitReschedule() {
    if (widget.appointment.id == null ||
        selectedSlot == null ||
        selectedDay == null)
      return;

    DateTime targetDate = _getNextDateForDay(selectedDay?.day ?? '');
    String formattedDate = targetDate.toIso8601String().split('T')[0];

    final slotStart = selectedSlot!;
    final slotEnd = selectedSlot!;

    context.read<AppointmentCubit>().reschedualAppointment(
      appointmentId: widget.appointment.id!,
      date: formattedDate,
      slotStart: slotStart,
      slotEnd: slotEnd,
      timeChosed: selectedSlot!,
    );
  }

  DateTime _getNextDateForDay(String dayName) {
    const mapDays = {
      'monday': DateTime.monday,
      'tuesday': DateTime.tuesday,
      'wednesday': DateTime.wednesday,
      'thursday': DateTime.thursday,
      'friday': DateTime.friday,
      'saturday': DateTime.saturday,
      'sunday': DateTime.sunday,
    };

    int targetWeekday =
        mapDays[dayName.toLowerCase().trim()] ?? DateTime.now().weekday;
    DateTime now = DateTime.now();
    int daysToAdd = (targetWeekday - now.weekday + 7) % 7;

    if (daysToAdd == 0) daysToAdd = 7;

    return now.add(Duration(days: daysToAdd));
  }

  @override
  Widget build(BuildContext context) {
    final rawName = widget.appointment.doctor?.userId?.name;
    final doctorName = (rawName != null && rawName.isNotEmpty)
        ? "DR. $rawName"
        : "DR. Unknown";
    final specialization =
        widget.appointment.doctor?.specialization ?? "Specialist";

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Reschedual',
          style: getBoldStyle(color: ColorManager.indigo800, fontSize: 22),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<AppointmentCubit, AppointmentState>(
        listener: (context, state) {
          if (state is RescheduleSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Appointment rescheduled successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          } else if (state is RescheduleErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: ColorManager.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is RescheduleLoadingState;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),

                  Text(
                    'Choose Time Slot',
                    style: getBoldStyle(
                      color: ColorManager.indigo800,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select your preferred date and time',
                    style: getMediumStyle(
                      color: ColorManager.indigo800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: ColorManager.primary,
                          child: Text(
                            widget.getInitials(rawName),
                            style: getBoldStyle(
                              color: ColorManager.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorName,
                              style: getBoldStyle(
                                color: ColorManager.indigo800,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              specialization,
                              style: getMediumStyle(
                                color: ColorManager.gray,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Select Date
                  Text(
                    'Select Date',
                    style: getBoldStyle(
                      color: ColorManager.indigo800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: daysList.isEmpty
                        ? const Center(child: Text('No days available'))
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: daysList.length,
                            itemBuilder: (context, index) {
                              final dayItem = daysList[index];
                              final bool isAvailable =
                                  SchedualAdapter.isDayAvailable(dayItem);
                              final bool isSelected = selectedDay == dayItem;

                              return GestureDetector(
                                onTap: isAvailable
                                    ? () => _selectDay(dayItem)
                                    : null,
                                child: Container(
                                  width: 65,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorManager.primary
                                        : (isAvailable
                                              ? ColorManager.white
                                              : ColorManager.gray),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorManager.primary
                                          : ColorManager.gray,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dayItem.day ?? '',
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        isAvailable ? 'Open' : 'Closed',
                                        style: getMediumStyle(
                                          color: isSelected
                                              ? ColorManager.white
                                              : (isAvailable
                                                    ? ColorManager.gray
                                                    : ColorManager.gray600),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 25),

                  Text(
                    'Available time',
                    style: getBoldStyle(
                      color: ColorManager.indigo800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: availableSlots.isEmpty
                        ? Center(
                            child: Text(
                              'No available slots for this day',
                              style: getBoldStyle(color: ColorManager.gray),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2.8,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 12,
                                ),
                            itemCount: availableSlots.length,
                            itemBuilder: (context, index) {
                              final slot = availableSlots[index];
                              final isSelected = selectedSlot == slot;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSlot = slot;
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorManager.primary
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: isSelected
                                          ? ColorManager.primary
                                          : ColorManager.gray,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    slot,
                                    style: getBoldStyle(
                                      color: isSelected
                                          ? ColorManager.white
                                          : ColorManager.gray,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: const BorderSide(
                                color: ColorManager.primary,
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: (selectedSlot != null && !isLoading)
                                ? _submitReschedule
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManager.primary,
                              disabledBackgroundColor: ColorManager.gray,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    'Done',
                                    style: getBoldStyle(
                                      color: ColorManager.white,
                                      fontSize: 15,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
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
