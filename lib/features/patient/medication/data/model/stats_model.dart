class Stats {
  Stats({this.avgAdherence, this.activeMedications});

  Stats.fromJson(dynamic json) {
    avgAdherence = json['avgAdherence'];
    activeMedications = json['activeMedications'];
  }

  String? avgAdherence;
  num? activeMedications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['avgAdherence'] = avgAdherence;
    map['activeMedications'] = activeMedications;
    return map;
  }
}
