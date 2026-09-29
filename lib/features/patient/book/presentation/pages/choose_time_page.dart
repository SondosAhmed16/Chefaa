import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_cubit.dart';
import 'package:chefaa/features/patient/book/presentation/cubit/book_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChooseTimePage extends StatefulWidget {
  const ChooseTimePage({super.key});

  @override
  State<ChooseTimePage> createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {
  final List<DateTime> _upcomingDays = List.generate(
    7,
    (index) => DateTime.now().add(Duration(days: index)),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = BookCubit.get(context);
      if (cubit.selectedDay == null && _upcomingDays.isNotEmpty) {
        cubit.selectDay(_upcomingDays.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        final cubit = BookCubit.get(context);
        final doctor = cubit.selectedDoctor;
        final clinic = cubit.selectedClinic;

        return Scaffold(
          backgroundColor: ColorManager.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(
                    "Choose Time Slot",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Select your preferred date and time.",
                    style: getMediumStyle(
                      color: ColorManager.gray,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: ColorManager.input),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              (doctor?.profilePicture != null &&
                                  doctor!.profilePicture!.isNotEmpty &&
                                  doctor.profilePicture!.startsWith('http'))
                              ? NetworkImage(doctor.profilePicture!)
                              : const AssetImage("assets/images/doctor.png")
                                    as ImageProvider,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor?.name ?? "Dr. Doctor Name",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doctor?.specialization ?? "Specialist",
                                style: getMediumStyle(
                                  color: ColorManager.gray,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (clinic?.price != null)
                          Text(
                            "${clinic!.price} E£",
                            style: getBoldStyle(
                              color: ColorManager.primary,
                              fontSize: 15,
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    "Select Date",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _upcomingDays.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, index) {
                        final date = _upcomingDays[index];
                        final isSelected =
                            cubit.selectedDay != null &&
                            DateUtils.isSameDay(cubit.selectedDay, date);

                        return GestureDetector(
                          onTap: () => cubit.selectDay(date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 60,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorManager.primary
                                  : ColorManager.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? ColorManager.primary
                                    : ColorManager.input,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('EEE').format(date),
                                  style: getMediumStyle(
                                    color: isSelected
                                        ? ColorManager.white
                                        : ColorManager.gray,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('dd').format(date),
                                  style: getBoldStyle(
                                    color: isSelected
                                        ? ColorManager.white
                                        : ColorManager.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 28),

                  Text(
                    "Available time",
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (state is GetSlotsLoadingState)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (cubit.slots.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          "No slots available for this date.",
                          style: getMediumStyle(
                            color: ColorManager.gray,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.8,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemCount: cubit.slots.length,
                      itemBuilder: (context, index) {
                        final slot = cubit.slots[index];
                        final timeString = slot.startTime ?? slot.toString();
                        final isSelected = cubit.selectedTime == timeString;

                        return GestureDetector(
                          onTap: () => cubit.selectTime(timeString),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorManager.primary
                                  : ColorManager.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: isSelected
                                    ? ColorManager.primary
                                    : ColorManager.input,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              timeString,
                              style: getSemiBoldStyle(
                                color: isSelected
                                    ? ColorManager.white
                                    : ColorManager.gray,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 36),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      onPressed: cubit.selectedTime != null
                          ? () {
                              cubit.nextStep();
                            }
                          : null,
                      child: Text(
                        "Continue",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
