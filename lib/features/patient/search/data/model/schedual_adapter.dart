import 'package:chefaa/features/patient/search/data/model/day.dart';
import 'package:flutter/material.dart';

class SchedualAdapter {
  static bool isDayAvailable(Day? day) {
    if (day == null) return false;
    return (day.isActive ?? false) &&
        !(day.isDayLocked ?? false) &&
        !(day.isBookingLocked ?? false);
  }

  static String formatMinutesToTime(int totalMinutes) {
    final int hours = (totalMinutes ~/ 60) % 24;
    final int minutes = totalMinutes % 60;
    final TimeOfDay time = TimeOfDay(hour: hours, minute: minutes);

    final String hourString = time.hourOfPeriod == 0
        ? '12'
        : time.hourOfPeriod.toString().padLeft(2, '0');
    final String minuteString = time.minute.toString().padLeft(2, '0');
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hourString:$minuteString $period';
  }

  static List<String> generateSlotsForDay(Day day, int defaultSlotDuration) {
    if (!isDayAvailable(day)) return [];

    final int openMinutes = day.open ?? 0;
    final int closeMinutes = day.close ?? 0;
    
    // تحويل آمن لتجنب Exception
    final int duration = int.tryParse(day.slotDuration?.toString() ?? '') ?? defaultSlotDuration;
    if (duration <= 0) return [];

    final breaks = day.breaks ?? [];

    List<String> slots = [];
    int current = openMinutes;

    while (current + duration <= closeMinutes) {
      int slotEnd = current + duration;

      bool isBreak = breaks.any((b) {
        if (b.start == null || b.end == null) return false;
        return (current < b.end!) && (slotEnd > b.start!);
      });

      if (!isBreak) {
        slots.add(formatMinutesToTime(current));
      }

      current += duration;
    }

    return slots;
  }
}