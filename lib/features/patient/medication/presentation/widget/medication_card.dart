import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/medication/data/model/medications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class MedicationCard extends StatelessWidget {
  final List<Medications> medications;
  final int index;
  final VoidCallback onPressed;
  const MedicationCard({
    super.key,
    required this.medications,
    required this.index,
    required this.onPressed,
  });

  String _formatDate(dynamic date) {
    if (date == null) return '';
    if (date is DateTime) {
      return DateFormat('yyyy/MM/dd').format(date);
    }
    if (date is String) {
      final parsedDate = DateTime.tryParse(date);
      if (parsedDate != null) {
        return DateFormat('yyyy/MM/dd').format(parsedDate);
      }
      return date;
    }
    return date.toString();
  }

  @override
  Widget build(BuildContext context) {
    final med = medications[index];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: ColorManager.input),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withAlpha(60),
            blurRadius: 7,
            offset: const Offset(1, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorManager.black.withAlpha(23),
                      blurRadius: 5,
                      offset: const Offset(1.5, 2),
                    ),
                  ],
                ),
                child: SvgPicture.asset("assets/svg_images/icon_2.svg"),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (med.name?.isNotEmpty == true)
                          ? med.name![0].toUpperCase() +
                                med.name!.substring(1).toLowerCase()
                          : "Medication Name",
                      style: getSemiBoldStyle(
                        fontSize: 18,
                        color: ColorManager.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${med.dosage} - ${med.form}",
                      style: getRegularStyle(
                        color: ColorManager.h2Color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.lightGreen.withAlpha(30),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "${med.calculatedAdherence??0}%",
                    style: getBoldStyle(
                      color: ColorManager.lightGreen,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              const Icon(Icons.access_time_rounded, color: ColorManager.gray),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${med.timesPerDay}x daily - ${med.schedule?.join(', ') ?? ''}",
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          Row(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: ColorManager.gray,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "${_formatDate(med.startDate)} - ${_formatDate(med.endDate)}",
                  style: getRegularStyle(
                    color: ColorManager.gray,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 50,
              height: 50,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(
                      color: ColorManager.primary,
                      width: 1.5,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "Edit",
                  style: getSemiBoldStyle(color: ColorManager.primary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
