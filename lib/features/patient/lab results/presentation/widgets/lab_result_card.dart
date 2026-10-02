import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/lab%20results/data/model/result.dart';
import 'package:flutter/material.dart';

class LabResultCard extends StatelessWidget {
  final Result result;
  final VoidCallback onViewPressed;
  final VoidCallback onNotesPressed;

  const LabResultCard({
    super.key,
    required this.result,
    required this.onViewPressed,
    required this.onNotesPressed,
  });

  IconData _getIconForTest(String? testName) {
    final name = (testName ?? '').toLowerCase();
    if (name.contains('blood')) return Icons.bloodtype_outlined;
    if (name.contains('urine')) return Icons.opacity_outlined;
    if (name.contains('scan') ||
        name.contains('x-ray') ||
        name.contains('radiology')) {
      return Icons.radio_button_checked_outlined;
    }
    return Icons.science_outlined;
  }

  Color _getColorForTest(String? testName) {
    final name = (testName ?? '').toLowerCase();
    if (name.contains('blood')) return Colors.redAccent;
    if (name.contains('urine')) return Colors.amber;
    if (name.contains('scan') ||
        name.contains('x-ray') ||
        name.contains('radiology')) {
      return Colors.purpleAccent;
    }
    return ColorManager.primary;
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return "Just now";
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return "${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    final testIcon = _getIconForTest(result.fileName);
    final themeColor = _getColorForTest(result.fileName);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: ColorManager.input.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: themeColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(testIcon, color: themeColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.fileName ?? 'Lab Report',
                      style: getBoldStyle(
                        color: ColorManager.black,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.labName ?? 'Laboratory',
                      style: getMediumStyle(
                        color: ColorManager.primary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: ColorManager.gray,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatDate(result.uploadedAt),
                          style: getRegularStyle(
                            color: ColorManager.gray,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (result.doctorNotes != null && result.doctorNotes!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorManager.lightGray.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: ColorManager.primary,
                    size: 14,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      result.doctorNotes!,
                      style: getRegularStyle(
                        color: ColorManager.darkGray,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onNotesPressed,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(
                      color: ColorManager.primary.withValues(alpha: 0.3),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Text(
                    "Doctor Notes",
                    style: getBoldStyle(
                      color: ColorManager.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton(
                  onPressed: onViewPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "View Document",
                        style: getBoldStyle(
                          color: ColorManager.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),

                      Icon(
                        Icons.open_in_new,
                        color: ColorManager.white,
                        size: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
