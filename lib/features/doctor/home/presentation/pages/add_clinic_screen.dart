import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/break.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_cubit.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddClinicScreen extends StatefulWidget {
  final String doctorId;
  const AddClinicScreen({super.key, required this.doctorId});

  @override
  State<AddClinicScreen> createState() => _AddClinicScreenState();
}

class _AddClinicScreenState extends State<AddClinicScreen> {
  final Map<String, List<Break>> dayBreaks = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DoctorHomeCubit>().resetForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: ColorManager.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Add New Clinic",
          style: getBoldStyle(color: ColorManager.white, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<DoctorHomeCubit, DoctorHomeState>(
        listener: (context, state) {
          if (state is AddClinicSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Clinic added successfully")),
            );
            Navigator.pop(context, true);
          } else if (state is AddClinicError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error.message)));
          }
        },
        builder: (context, state) {
          final isAddLoading = state is AddClinicLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Clinic Information",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: cubit.nameController,
                  text: "Clinic Name",
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  controller: cubit.addressController,
                  text: "Address",
                ),
                SizedBox(height: 12.h),
                CustomTextField(controller: cubit.cityController, text: "City"),
                SizedBox(height: 12.h),
                CustomTextField(
                  controller: cubit.priceController,
                  text: "Price",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  controller: cubit.operatingLicenseController,
                  text: "Operating License",
                ),
                SizedBox(height: 16.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.slotDurationController,
                        text: "Slot Duration (Min)",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomTextField(
                        controller: cubit.dailyCapacityController,
                        text: "Daily Capacity",
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                CustomTextField(
                  controller: cubit.patientsPerSlotController,
                  text: "Patients Per Slot",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),

                Text(
                  "Working Days & Hours & Breaks",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 16),
                ),
                SizedBox(height: 10.h),
                ...cubit.selectedDays.keys.map((day) {
                  final isSelected = cubit.selectedDays[day] ?? false;
                  final breaksList = dayBreaks[day] ?? [];

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? ColorManager.primary
                            : ColorManager.gray,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            day,
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 14,
                            ),
                          ),
                          value: isSelected,
                          activeColor: ColorManager.primary,
                          onChanged: (_) {
                            cubit.onDayTap(day);
                            setState(() {});
                          },
                        ),
                        if (isSelected) ...[
                          Row(
                            children: [
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    await cubit.pickTime(
                                      context: context,
                                      day: day,
                                      isOpen: true,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.access_time, size: 16),
                                  label: Text(
                                    cubit.openTimes[day] != null
                                        ? cubit.openTimes[day]!.format(context)
                                        : "Open Time",
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    await cubit.pickTime(
                                      context: context,
                                      day: day,
                                      isOpen: false,
                                    );
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.access_time, size: 16),
                                  label: Text(
                                    cubit.closeTimes[day] != null
                                        ? cubit.closeTimes[day]!.format(context)
                                        : "Close Time",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(),

                          if (breaksList.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Breaks:",
                                style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            ...breaksList.asMap().entries.map((entry) {
                              final index = entry.key;
                              final b = entry.value;
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  b.label ?? 'Break',
                                  style: getMediumStyle(
                                    color: ColorManager.black,
                                    fontSize: 13,
                                  ),
                                ),
                                subtitle: Text(
                                  "${_formatMinutes(b.start)} - ${_formatMinutes(b.end)}",
                                  style: getRegularStyle(
                                    color: ColorManager.gray,
                                    fontSize: 12,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: ColorManager.error,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      breaksList.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            }),
                          ],

                          TextButton.icon(
                            onPressed: () {
                              _showAddBreakBottomSheet(context, day);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 16,
                              color: ColorManager.primary,
                            ),
                            label: Text(
                              "Add Break",
                              style: getBoldStyle(
                                color: ColorManager.primary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }),
                SizedBox(height: 24.h),

                CustemButton(
                  text: "Add Clinic",
                  isLoading: isAddLoading,
                  onPressed: () {
                    cubit.addClinic(doctorId: widget.doctorId);
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddBreakBottomSheet(BuildContext context, String day) {
    final labelController = TextEditingController();
    TimeOfDay? startTime;
    TimeOfDay? endTime;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 20.h,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Break for $day",
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  CustomTextField(
                    controller: labelController,
                    text: "Break Label (e.g., Lunch Break)",
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setSheetState(() {
                                startTime = picked;
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time, size: 16),
                          label: Text(
                            startTime != null
                                ? startTime!.format(context)
                                : "Start Time",
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () async {
                            final picked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (picked != null) {
                              setSheetState(() {
                                endTime = picked;
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time, size: 16),
                          label: Text(
                            endTime != null
                                ? endTime!.format(context)
                                : "End Time",
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustemButton(
                    text: "Add Break",
                    isLoading: false,
                    onPressed: () {
                      if (labelController.text.isNotEmpty &&
                          startTime != null &&
                          endTime != null) {
                        final startMin =
                            startTime!.hour * 60 + startTime!.minute;
                        final endMin = endTime!.hour * 60 + endTime!.minute;

                        setState(() {
                          dayBreaks.putIfAbsent(day, () => []);
                          dayBreaks[day]!.add(
                            Break(
                              label: labelController.text.trim(),
                              start: startMin,
                              end: endMin,
                            ),
                          );
                        });
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String _formatMinutes(num? totalMinutes) {
    if (totalMinutes == null) return "";
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    final hourFormatted = hours > 12 ? hours - 12 : (hours == 0 ? 12 : hours);
    final period = hours >= 12 ? "PM" : "AM";
    return "$hourFormatted:${minutes.toString().padLeft(2, '0')} $period";
  }
}
