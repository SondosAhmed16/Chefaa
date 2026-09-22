import 'medication.dart';

class MedicationResponse {
  MedicationResponse({this.message, this.medication});

  MedicationResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>)
      throw const FormatException('Invalid JSON');
    message = json['message'];
    medication = json['medication'] != null
        ? Medication.fromJson(json['medication'])
        : null;
  }

  String? message;
  Medication? medication;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (medication != null) {
      map['medication'] = medication?.toJson();
    }
    return map;
  }
}
