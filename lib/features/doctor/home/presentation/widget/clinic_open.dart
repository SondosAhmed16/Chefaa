import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';

class ClinicOpen extends StatelessWidget {
  final List<dynamic> days;
  const ClinicOpen({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final thisDay = _getTodayName();
    final isOpen = days.any(
      (day) => day.day == thisDay && day.isActive == true,
    );
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isOpen ? ColorManager.green600 : ColorManager.error,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isOpen ? Icons.done_rounded : Icons.close_rounded,
            color: ColorManager.white,
            size: 25,
          ),

          const SizedBox(width: 5),
          Text(
            isOpen ? "Clinic Open Today" : "Clinic Closed Today",
            style: getBoldStyle(color: ColorManager.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  String _getTodayName() {
    final now = DateTime.now();

    switch (now.weekday) {
      case 1:
        return "Monday";

      case 2:
        return "Tuesday";

      case 3:
        return "Wednesday";

      case 4:
        return "Thursday";

      case 5:
        return "Friday";

      case 6:
        return "Saturday";

      case 7:
        return "Sunday";

      default:
        return "";
    }
  }
}
