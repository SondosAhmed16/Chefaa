import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/medication/data/model/medications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MedicineCard extends StatefulWidget {
  final List<Medications> medications;
  final Function(Medications medication) onPressed;

  const MedicineCard({
    super.key,
    required this.medications,
    required this.onPressed,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 80.h, maxHeight: 200.h),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(color: ColorManager.black.withAlpha(80), blurRadius: 10),
          ],
        ),
        child: RawScrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 5,
          radius: const Radius.circular(10),
          trackVisibility: false,
          thumbColor: ColorManager.gray.withAlpha(80),
          minThumbLength: 30,
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            itemCount: widget.medications.length,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(right: 8),
            separatorBuilder: (_, _) => const Divider(),
            itemBuilder: (_, index) {
              final med = widget.medications[index];

              final lastHistoryStatus = med.adherenceHistory?.isNotEmpty == true
                  ? med.adherenceHistory!.last.status
                  : null;

              final isAlreadyTaken =
                  lastHistoryStatus?.toLowerCase() == 'taken';

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
                  isAlreadyTaken
                      ? _ConfirmedStatus(
                          statusText: lastHistoryStatus ?? 'Taken',
                        )
                      : _ConfirmActions(onConfirm: () => widget.onPressed(med)),
                ],
              );
            },
          ),
        ),
      ),
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
          child: Text(
            'Confirm',
            style: getMediumStyle(color: ColorManager.primary),
          ),
          onPressed: onConfirm,
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
    final displayStatus = statusText.isNotEmpty
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
