import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';
import 'package:intl/intl.dart';

void showBottomSheetMedication(BuildContext context, {dynamic medication}) {
  final cubit = BlocProvider.of<MedicationCubit>(context);

  if (medication != null) {
    cubit.nameController.text = medication.name ?? '';
    cubit.dosageController.text =
        medication.dosage?.replaceAll(' mg', '') ?? '';
    cubit.formController.text = medication.form ?? '';
    
    cubit.startDateController.text = _formatDateString(medication.startDate);
    cubit.endDateController.text = _formatDateString(medication.endDate);

    cubit.isActive = medication.isActive ?? true;
    cubit.timesPerDay = medication.timesPerDay?.toInt() ?? 1;
    cubit.timesPerDayController.text = cubit.timesPerDay.toString();
  } else {
    cubit.clearControllers();
    cubit.timesPerDay = 1;
    cubit.timesPerDayController.text = '1';
    cubit.isActive = true;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: ColorManager.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (modalContext) {
      return BlocProvider.value(
        value: cubit,
        child: BottomSheetMedication(medication: medication),
      );
    },
  );
}

String _formatDateString(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return '';
  try {
    final parsedDate = DateTime.parse(dateStr);
    return DateFormat('yyyy/MM/dd').format(parsedDate);
  } catch (e) {
    if (dateStr.contains('T')) {
      return dateStr.split('T').first.replaceAll('-', '/');
    }
    return dateStr;
  }
}

class BottomSheetMedication extends StatefulWidget {
  final dynamic medication;

  const BottomSheetMedication({super.key, this.medication});

  @override
  State<BottomSheetMedication> createState() => _BottomSheetMedicationState();
}

class _BottomSheetMedicationState extends State<BottomSheetMedication> {
  bool get isEditing => widget.medication != null;

  final List<TextEditingController> _doseControllers = [];

  @override
  void initState() {
    super.initState();
    _initDoseControllers();
  }

  void _initDoseControllers() {
    final cubit = context.read<MedicationCubit>();

    if (isEditing &&
        widget.medication.schedule != null &&
        widget.medication.schedule.isNotEmpty) {
      for (var timeStr in widget.medication.schedule) {
        _doseControllers.add(TextEditingController(text: timeStr.toString()));
      }
      cubit.timesPerDay = _doseControllers.length;
      cubit.timesPerDayController.text = cubit.timesPerDay.toString();
    } else {
      _updateDoseControllersCount();
    }
  }

  void _updateDoseControllersCount() {
    final cubit = context.read<MedicationCubit>();
    int count = cubit.timesPerDay;
    if (count > 5) count = 5;
    if (count < 1) count = 1;

    while (_doseControllers.length < count) {
      _doseControllers.add(TextEditingController(text: "09:00 AM"));
    }
    while (_doseControllers.length > count) {
      _doseControllers.removeLast();
    }
  }

  Future<void> _pickTime(
      BuildContext context, TextEditingController controller, int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        controller.text = _formatTimeOfDay(picked);

        if (index == 0 && _doseControllers.length > 1) {
          int timesPerDay = _doseControllers.length;
          double intervalHours = 24 / timesPerDay;

          int baseHour = picked.hour;
          int baseMinute = picked.minute;

          for (int i = 1; i < _doseControllers.length; i++) {
            double totalMinutes =
                (baseHour * 60 + baseMinute) + (intervalHours * 60 * i);
            int nextHour = (totalMinutes ~/ 60) % 24;
            int nextMinute = (totalMinutes % 60).round();

            TimeOfDay nextTime = TimeOfDay(hour: nextHour, minute: nextMinute);
            _doseControllers[i].text = _formatTimeOfDay(nextTime);
          }
        }
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  Future<void> _pickDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy/MM/dd').format(picked);
      });
    }
  }

  @override
  void dispose() {
    for (var c in _doseControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicationCubit>();

    return BlocListener<MedicationCubit, MedicationState>(
      listener: (context, state) {
        if (state is MedicationAdditionSuccessState ||
            state is MedicationUpdateSuccessState ||
            state is MedicationDeleteSuccessState) {
          Navigator.pop(context);
          cubit.getMedicationList(forceRefresh: true);
        }
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Container(
                    width: 50,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  isEditing ? "Edit Medication" : "Add Medication",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  isEditing
                      ? "Update your medication details."
                      : "Enter your medication details for tracking and reminders",
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),

                _buildCardSection(
                  children: [
                    const Text(
                      "Medication Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: cubit.nameController,
                      text: "e.g., Metformin",
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Dosage",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: cubit.dosageController,
                      text: "e.g., 500mg",
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Form",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: cubit.formController,
                      text: "Tablet",
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                _buildCardSection(
                  children: [
                    Text(
                      "Schedule",
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Times per day (1 to 5)",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: cubit.timesPerDayController,
                      text: "1",
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        int? parsed = int.tryParse(val);
                        if (parsed != null && parsed >= 1 && parsed <= 5) {
                          setState(() {
                            cubit.timesPerDay = parsed;
                            _updateDoseControllersCount();
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Times Schedule",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _doseControllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dose ${index + 1}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => _pickTime(
                                    context, _doseControllers[index], index),
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: _doseControllers[index],
                                    text: "Select Time",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Date",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () =>
                                    _pickDate(context, cubit.startDateController),
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: cubit.startDateController,
                                    text: "Select Start Date",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "End Date",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () =>
                                    _pickDate(context, cubit.endDateController),
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: cubit.endDateController,
                                    text: "Select End Date",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Continuous medication",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Switch(
                          value: cubit.isActive,
                          onChanged: (val) {
                            setState(() {
                              cubit.isActive = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                BlocBuilder<MedicationCubit, MedicationState>(
                  builder: (context, state) {
                    bool isLoading =
                        state is MedicationAdditionLoadingState ||
                        state is MedicationUpdateLoadingState;

                    return CustemButton(
                      text: isEditing ? "Save Medication" : "Add Medication",
                      isLoading: isLoading,
                      onPressed: () {
                        cubit.scheduleController.text =
                            _doseControllers.map((e) => e.text).join(',');

                        if (isEditing) {
                          cubit.updateMedication(
                            medicationId: widget.medication.id,
                          );
                        } else {
                          cubit.addMedication();
                        }
                        Navigator.pop(context);
                      },
                    );
                  },
                ),

                if (isEditing) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        cubit.deleteMedication(widget.medication.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: ColorManager.error,
                      ),
                      label: Text(
                        "Delete",
                        style: getMediumStyle(
                          color: ColorManager.error,
                          fontSize: 16,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: ColorManager.error),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardSection({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [
          BoxShadow(
            color: ColorManager.gray,
            blurRadius: 10,
            offset: Offset(1, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}