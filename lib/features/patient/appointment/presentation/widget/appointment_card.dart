import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:chefaa/features/patient/appointment/data/model/datum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentCard extends StatelessWidget {
  final Datum appointment;
  final VoidCallback onDecline;
  final VoidCallback onReschedule;
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onDecline,
    required this.onReschedule,
  });

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return "DR";
    List<String> names = name.trim().split(" ");
    if (names.length >= 2) {
      return "${names[0][0]}${names[1][0]}".toUpperCase();
    }
    return names[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final doctorName = appointment.doctor?.userId?.name != null
        ? "DR. ${appointment.doctor?.userId?.name}"
        : "DR. Unknown";
    final specialization = appointment.doctor?.specialization ?? "Specialist";
    final status = (appointment.status ?? "upcoming").toLowerCase();

    final bool isDeclined = status == 'cancelled';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: ColorManager.primary,
                child: Text(
                  _getInitials(doctorName),
                  style: getBoldStyle(color: ColorManager.white, fontSize: 18),
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorName,
                      style: getBoldStyle(
                        color: ColorManager.indigo800,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialization,
                      style: getMediumStyle(
                        color: ColorManager.gray,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              _buildStatusBadge(status),
            ],
          ),

          if (!isDeclined) ...[
            const SizedBox(height: 16),

            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: ColorManager.gray,
                ),
                const SizedBox(width: 8),
                Text(
                  '${appointment.date != null ? DateFormat('dd MMM yyyy').format(appointment.date!) : ''}${appointment.date != null && appointment.timeChosed != null ? ' – ' : ''}${appointment.timeChosed ?? ''}',
                  style: getRegularStyle(color: ColorManager.gray),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDecline,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorManager.error),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      'Decline',
                      style: getSemiBoldStyle(
                        color: ColorManager.error,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Reschedule Button
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReschedule,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: ColorManager.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(
                      'Reschedule',
                      style: getBoldStyle(
                        color: ColorManager.primary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color backgroundColor;
    Color textColor;
    String text = status;

    if (status == 'completed') {
      backgroundColor = ColorManager.green100;
      textColor = ColorManager.greenOverlay;
      text = 'confirmed';
    } else if (status == 'cancelled') {
      backgroundColor = ColorManager.lightRed;
      textColor = ColorManager.error;
      text = 'Declined';
    } else {
      backgroundColor = ColorManager.blue100;
      textColor = ColorManager.blue600;
      text = 'upcoming';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: getMediumStyle(color: textColor, fontSize: 18)),
    );
  }
}
