class ReschedualModel {
  final String date;
  final String slotStart;
  final String slotEnd;
  final String timeChosed;

  ReschedualModel({
    required this.date,
    required this.slotStart,
    required this.slotEnd,
    required this.timeChosed,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'slotStart': slotStart,
      'slotEnd': slotEnd,
      'timeChosed': timeChosed,
    };
  }
}
