import 'medication.dart';

class ConfirmMedication {
  ConfirmMedication({this.message, this.adherenceRate, this.medication});

  ConfirmMedication.fromJson(dynamic json) {
    message = json['message'];
    adherenceRate = json['adherenceRate'];
    medication = json['medication'] != null
        ? Medication.fromJson(json['medication'])
        : null;
  }

  String? message;
  String? adherenceRate;
  Medication? medication;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['adherenceRate'] = adherenceRate;
    if (medication != null) {
      map['medication'] = medication?.toJson();
    }
    return map;
  }
}
