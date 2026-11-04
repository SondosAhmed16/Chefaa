import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/medication/data/model/medications.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_cubit.dart';
import 'package:chefaa/features/patient/medication/presentation/cubit/medication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineCard extends StatelessWidget {
  final List<Medications> medications;
  final Function(Medications medication) onPressed;

  const MedicineCard({
    super.key,
    required this.medications,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MedicationCubit, MedicationState>(
      builder: (context, state) {
        List<Medications> currentMedications = medications;
        if (state is MedicationListSuccessState) {
          currentMedications = (state.medications.medications ?? [])
              .where((med) => med.isActive == true)
              .toList();
        }

        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: 80.h, maxHeight: 200.h),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: ColorManager.black.withAlpha(10),
                  blurRadius: 4,
                  offset: const Offset(2, 10),
                ),
              ],
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: currentMedications.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 8),
              separatorBuilder: (_, _) => const Divider(),
              itemBuilder: (_, index) {
                final med = currentMedications[index];

                bool isAlreadyTakenToday = false;
                String? lastStatus;

                if (med.adherenceHistory != null &&
                    med.adherenceHistory!.isNotEmpty) {
                  for (var history in med.adherenceHistory!) {
                    if (history.date != null) {
                      try {
                        final historyDate = DateTime.parse(history.date!);
                        final now = DateTime.now();

                        if (historyDate.year == now.year &&
                            historyDate.month == now.month &&
                            historyDate.day == now.day) {
                          if (history.status?.toLowerCase() == 'taken') {
                            isAlreadyTakenToday = true;
                            lastStatus = history.status;
                            break;
                          }
                        }
                      } catch (e) {}
                    }
                  }
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            med.name?.isNotEmpty == true
                                ? med.name![0].toUpperCase() +
                                      med.name!.substring(1).toLowerCase()
                                : 'Medication Name',
                            style: getBoldStyle(
                              color: ColorManager.black,
                            ).copyWith(fontSize: 18),
                          ),
                          5.verticalSpace,
                          Text(
                            '${med.dosage} - ${med.schedule?.join(', ')}',
                            style: getMediumStyle(
                              color: ColorManager.gray,
                            ).copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    12.horizontalSpace,

                    isAlreadyTakenToday
                        ? _ConfirmedStatus(statusText: lastStatus ?? 'Taken')
                        : _ConfirmActions(
                            onConfirm: () {
                              onPressed(med);
                            },
                          ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ConfirmActions extends StatelessWidget {
  final VoidCallback onConfirm;

  const _ConfirmActions({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: ColorManager.gray,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: const Icon(
            Icons.access_time_rounded,
            color: ColorManager.white,
            size: 20,
          ),
        ),
        20.horizontalSpace,
        ElevatedButton(
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: getMediumStyle(color: ColorManager.primary),
          ),
        ),
      ],
    );
  }
}

class _ConfirmedStatus extends StatelessWidget {
  final String statusText;

  const _ConfirmedStatus({required this.statusText});

  @override
  Widget build(BuildContext context) {
    final String displayStatus = statusText.isNotEmpty
        ? statusText[0].toUpperCase() + statusText.substring(1).toLowerCase()
        : 'Taken';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check_outlined, color: Colors.green, size: 22),
        8.horizontalSpace,
        Text(
          displayStatus,
          style: getMediumStyle(
            color: Colors.green.shade800,
          ).copyWith(fontSize: 16),
        ),
      ],
    );
  }
}
