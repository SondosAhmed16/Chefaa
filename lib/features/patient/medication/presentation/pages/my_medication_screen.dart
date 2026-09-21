import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/core/widgets/custom_dialog.dart';
import 'package:chefaa/core/widgets/patient_advice.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';
import 'package:chefaa/features/patient/medication/presentation/widget/bottom_sheet_medication.dart';
import 'package:chefaa/features/patient/medication/presentation/widget/medication_card.dart';
import 'package:chefaa/features/patient/medication/presentation/widget/state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyMedicationScreen extends StatelessWidget {
  const MyMedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 20,
          ),
          decoration: const BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 20,
                      color: ColorManager.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "My Medications",
                    style: getBoldStyle(
                      color: ColorManager.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  "Track and manage your medication schedule",
                  style: getMediumStyle(
                    color: ColorManager.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<MedicationCubit, MedicationState>(
              buildWhen: (previous, current) {
                return current is MedicationListSuccessState ||
                    current is MedicationListLoadingState ||
                    current is MedicationListErrorState;
              },
              builder: (context, state) {
                int activeCount = 0;
                num avgAdherence = 0;
                if (state is MedicationListSuccessState) {
                  
                  final stats = state.medications.stats;
                  final list = state.medications.medications ?? [];

                  activeCount =
                      stats?.activeMedications?.toInt() ??
                      list.where((m) => m.isActive == true).length;

                  if (stats?.avgAdherence != null) {
                    String cleanAvg = stats!.avgAdherence!
                        .replaceAll('%', '')
                        .trim();
                    avgAdherence = num.tryParse(cleanAvg) ?? 0;
                  } else {
                    avgAdherence = 0;
                  }
                }
                return Row(
                  children: [
                    Expanded(
                      child: StateCard(
                        title: "Avg. Adherence",
                        text: "$avgAdherence%",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: StateCard(
                        title: "Active Medications",
                        text: "$activeCount",
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 12),

            const StateCard(
              title: "Upcoming Dose",
              text: "Metformin 500mg at 8:00 PM (in 3 hours)",
              iconPath: "assets/svg_images/Icon.svg",
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Medications",
                  style: getBoldStyle(color: ColorManager.black, fontSize: 20),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showBottomSheetMedication(context);
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 18,
                    color: ColorManager.white,
                  ),
                  label: Text(
                    "Add Medication",
                    style: getMediumStyle(
                      color: ColorManager.white,
                      fontSize: 14,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            BlocBuilder<MedicationCubit, MedicationState>(
              buildWhen: (previous, current) {
                return current is MedicationListSuccessState ||
                    current is MedicationListLoadingState ||
                    current is MedicationListErrorState;
              },
              builder: (context, state) {
                if (state is MedicationListLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MedicationListErrorState) {
                  return CustomDialog(
                    title: "Failed",
                    message: state.errorMessage,
                    type: DialogType.fail,
                  );
                } else if (state is MedicationListSuccessState) {
                  final medications = state.medications.medications ?? [];
                  if (medications.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(
                          "No medications added yet.",
                          style: getMediumStyle(color: ColorManager.gray),
                        ),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: medications.length,
                    separatorBuilder: (context, index) {
                      if (index == 1) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: PatientAdvice(
                            text:
                                "You often miss your 9AM dose. Would you like to take it at 10AM instead?",
                          ),
                        );
                      }
                      return const SizedBox(height: 16);
                    },
                    itemBuilder: (context, index) {
                      final item = medications[index];
                      return MedicationCard(
                        medications: medications,
                        index: index,
                        onPressed: () {
                          showBottomSheetMedication(context, medication: item);
                        },
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
