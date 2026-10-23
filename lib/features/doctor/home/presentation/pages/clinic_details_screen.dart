import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/doctor/home/data/model/clinic_model/break.dart';
import 'package:chefaa/features/doctor/home/data/model/clinics_model/clinics.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_cubit.dart';
import 'package:chefaa/features/doctor/home/presentation/cubit/doctor_home_state.dart';
import 'package:chefaa/features/doctor/home/presentation/widget/clinic_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicDetailsScreen extends StatefulWidget {
  final String clinicId;

  const ClinicDetailsScreen({super.key, required this.clinicId});

  @override
  State<ClinicDetailsScreen> createState() => _ClinicDetailsScreenState();
}

class _ClinicDetailsScreenState extends State<ClinicDetailsScreen> {
  bool isEditing = false;
  bool isDataInitialized = false;
  bool hasBeenUpdated = false;

  final Map<String, List<Break>> dayBreaks = {};

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
      },
      child: Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ColorManager.white),
            onPressed: () => Navigator.pop(context, hasBeenUpdated),
          ),
          title: Text(
            "Clinic Details",
            style: getBoldStyle(color: ColorManager.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<DoctorHomeCubit, DoctorHomeState>(
          listener: (context, state) {
            if (state is DeleteClinicSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message ?? "Clinic deleted successfully"),
                ),
              );
              Navigator.pop(context, true);
            } else if (state is DeleteClinicError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error.message)));
            } else if (state is UpdateClinicSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Clinic updated successfully")),
              );
              setState(() {
                isEditing = false;
                isDataInitialized = false;
                hasBeenUpdated = true;
              });
              cubit.getMyClinic(clinicId: widget.clinicId);
            } else if (state is UpdateClinicError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error.message)));
            }
          },
          builder: (context, state) {
            if (state is DoctorClinicLoading) {
              return const Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is DoctorClinicError) {
              return Center(
                child: Text(
                  state.error.message,
                  style: getBoldStyle(color: ColorManager.error, fontSize: 16),
                ),
              );
            }

            final clinicData = cubit.currentClinic;

            if (clinicData != null && !isDataInitialized) {
              cubit.nameController.text = clinicData.name ?? '';
              cubit.addressController.text = clinicData.address ?? '';
              cubit.cityController.text = clinicData.city ?? '';
              cubit.priceController.text = clinicData.price?.toString() ?? '';
              cubit.operatingLicenseController.text =
                  clinicData.operatingLicense ?? '';

              if (clinicData.location?.coordinates != null &&
                  clinicData.location!.coordinates!.length >= 2) {
                cubit.longitudeController.text = clinicData
                    .location!
                    .coordinates![0]
                    .toString();
                cubit.latitudeController.text = clinicData
                    .location!
                    .coordinates![1]
                    .toString();
              }

              if (clinicData.defaultSchedule != null) {
                cubit.slotDurationController.text =
                    clinicData.defaultSchedule?.slotDuration?.toString() ??
                    '30';
                cubit.dailyCapacityController.text =
                    clinicData.defaultSchedule?.dailyCapacity?.toString() ??
                    '20';
                cubit.patientsPerSlotController.text =
                    clinicData.defaultSchedule?.patientsPerSlot?.toString() ??
                    '1';

                if (clinicData.defaultSchedule?.days != null) {
                  for (var dayObj in clinicData.defaultSchedule!.days!) {
                    final dayName = dayObj.day;
                    if (dayName != null &&
                        cubit.selectedDays.containsKey(dayName)) {
                      cubit.selectedDays[dayName] = dayObj.isActive ?? false;

                      if (dayObj.open != null) {
                        cubit.openTimes[dayName] = TimeOfDay(
                          hour: (dayObj.open! ~/ 60).toInt(),
                          minute: (dayObj.open! % 60).toInt(),
                        );
                      }
                      if (dayObj.close != null) {
                        cubit.closeTimes[dayName] = TimeOfDay(
                          hour: (dayObj.close! ~/ 60).toInt(),
                          minute: (dayObj.close! % 60).toInt(),
                        );
                      }

                      if (dayObj.breaks != null) {
                        dayBreaks[dayName] = dayObj.breaks!
                            .map(
                              (b) => Break(
                                label: b.label,
                                start: b.start,
                                end: b.end,
                              ),
                            )
                            .toList();
                      } else {
                        dayBreaks[dayName] = [];
                      }
                    }
                  }
                }
              }
              isDataInitialized = true;
            }

            final clinicCardModel = clinicData != null
                ? Clinics(
                    id: clinicData.id,
                    name: clinicData.name,
                    city: clinicData.city,
                    address: clinicData.address,
                    defaultSchedule: clinicData.defaultSchedule,
                  )
                : null;

            final isDeleteLoading = state is DeleteClinicLoading;
            final isUpdateLoading = state is UpdateClinicLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (clinicCardModel != null && !isEditing) ...[
                    Stack(
                      children: [
                        ClinicCard(clinic: clinicCardModel, onPressed: () {}),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],

                  if (!isEditing) ...[
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            title: "Consultation",
                            value: "${clinicData?.price ?? 0} EGP",
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildInfoBox(
                            title: "Slot Duration",
                            value:
                                "${clinicData?.defaultSchedule?.slotDuration ?? 30} Min",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoBox(
                            title: "Max Cases",
                            value:
                                "${clinicData?.defaultSchedule?.dailyCapacity ?? 0} Patients",
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildInfoBox(
                            title: "Per Slot",
                            value:
                                "${clinicData?.defaultSchedule?.patientsPerSlot ?? 1} Patient",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "License",
                            style: getRegularStyle(
                              color: ColorManager.gray,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            clinicData?.operatingLicense ?? "N/A",
                            style: getBoldStyle(
                              color: ColorManager.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Text(
                      "Schedule & Breaks",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (clinicData?.defaultSchedule?.days != null)
                      ...clinicData!.defaultSchedule!.days!.map((day) {
                        if (day.isActive != true)
                          return const SizedBox.shrink();
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: ColorManager.lightGray,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    day.day ?? "",
                                    style: getBoldStyle(
                                      color: ColorManager.primary,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "${_formatMinutes(day.open)} - ${_formatMinutes(day.close)}",
                                    style: getRegularStyle(
                                      color: ColorManager.black,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              if (day.breaks != null &&
                                  day.breaks!.isNotEmpty) ...[
                                SizedBox(height: 8.h),
                                const Divider(),
                                Text(
                                  "Breaks:",
                                  style: getBoldStyle(
                                    color: ColorManager.gray,
                                    fontSize: 12,
                                  ),
                                ),
                                ...day.breaks!.map(
                                  (b) => Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "• ${b.label ?? 'Break'}",
                                          style: getRegularStyle(
                                            color: ColorManager.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${_formatMinutes(b.start)} - ${_formatMinutes(b.end)}",
                                          style: getRegularStyle(
                                            color: ColorManager.gray,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        );
                      }),

                    SizedBox(height: 24.h),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: ElevatedButton(
                              onPressed: isDeleteLoading
                                  ? null
                                  : () {
                                      if (widget.clinicId.isNotEmpty) {
                                        final doctorId =
                                            cubit.currentClinic?.doctorId;
                                        if (doctorId != null) {
                                          cubit.deleteMyClinic(
                                            clinicId: widget.clinicId,
                                            doctorId: doctorId,
                                          );
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.error,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: isDeleteLoading
                                  ? const CircularProgressIndicator(
                                      color: ColorManager.white,
                                    )
                                  : Text(
                                      "Delete Clinic",
                                      style: getBoldStyle(
                                        color: ColorManager.white,
                                        fontSize: 14,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustemButton(
                            text: "Edit Clinic",
                            isLoading: false,
                            onPressed: () {
                              setState(() {
                                isEditing = true;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Text(
                      "Edit Clinic Information",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
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
                    CustomTextField(
                      controller: cubit.cityController,
                      text: "City",
                    ),
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
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
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
                                      icon: const Icon(
                                        Icons.access_time,
                                        size: 16,
                                      ),
                                      label: Text(
                                        cubit.openTimes[day] != null
                                            ? cubit.openTimes[day]!.format(
                                                context,
                                              )
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
                                      icon: const Icon(
                                        Icons.access_time,
                                        size: 16,
                                      ),
                                      label: Text(
                                        cubit.closeTimes[day] != null
                                            ? cubit.closeTimes[day]!.format(
                                                context,
                                              )
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

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50.h,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  isEditing = false;
                                  isDataInitialized = false;
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: ColorManager.gray,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: getBoldStyle(
                                  color: ColorManager.gray,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustemButton(
                            text: "Save Changes",
                            isLoading: isUpdateLoading,
                            onPressed: () {
                              if (widget.clinicId.isNotEmpty) {
                                final doctorId = cubit.currentClinic?.doctorId;
                                if (doctorId != null) {
                                  cubit.updateClinic(
                                    clinicId: widget.clinicId,
                                    doctorId: doctorId,
                                    dayBreaks: dayBreaks,
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  SizedBox(height: 20.h),
                ],
              ),
            );
          },
        ),
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

  Widget _buildInfoBox({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: getRegularStyle(color: ColorManager.gray, fontSize: 12),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: getBoldStyle(color: ColorManager.black, fontSize: 15),
          ),
        ],
      ),
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
