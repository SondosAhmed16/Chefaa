import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custem_button.dart';
import 'package:chefaa/core/widgets/custom_text_feild.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';

void showBottomSheetMedication(BuildContext context, {dynamic medication}) {
  final cubit = BlocProvider.of<MedicationCubit>(context);

  if (medication != null) {
    cubit.nameController.text = medication.name ?? '';
    cubit.dosageController.text =
        medication.dosage?.replaceAll(' mg', '') ?? '';
    cubit.formController.text = medication.form ?? '';
    cubit.startDateController.text = medication.startDate ?? '';
    cubit.endDateController.text = medication.endDate ?? '';
    cubit.isActive = medication.isActive ?? false;
  } else {
    cubit.clearControllers();
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

class BottomSheetMedication extends StatefulWidget {
  final dynamic medication;

  const BottomSheetMedication({super.key, this.medication});

  @override
  State<BottomSheetMedication> createState() => _BottomSheetMedicationState();
}

class _BottomSheetMedicationState extends State<BottomSheetMedication> {
  bool get isEditing => widget.medication != null;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MedicationCubit>();

    return BlocListener<MedicationCubit, MedicationState>(
      listener: (context, state) {
        if (state is MedicationAdditionSuccessState ||
            state is MedicationUpdateSuccessState ||state is MedicationDeleteSuccessState) {
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
                // Handle Bar
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

                // Title
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
                      "Times per day",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    CustomTextField(
                      controller: cubit.timesPerDayController,
                      text: "2 times/day",
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Times Schedule",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    // Doses Rows (Dose 1 & Dose 2)
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Dose 1",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomTextField(
                                controller: TextEditingController(
                                  text: "09:00 AM",
                                ),
                                text: "09:00 AM",
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
                                "Dose 2",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              CustomTextField(
                                controller: TextEditingController(
                                  text: "09:00 PM",
                                ),
                                text: "09:00 PM",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Start Date & End Date
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
                              CustomTextField(
                                controller: cubit.startDateController,
                                text: "12/12/2025",
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
                              CustomTextField(
                                controller: cubit.endDateController,
                                text: "26/12/2025",
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

                // Action Button (Save / Add)
                BlocBuilder<MedicationCubit, MedicationState>(
                  builder: (context, state) {
                    bool isLoading =
                        state is MedicationAdditionLoadingState ||
                        state is MedicationUpdateLoadingState;

                    return CustemButton(
                      text: isEditing ? "Save Medication" : "Add Medication",
                      isLoading: isLoading,
                      onPressed: () {
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
