import 'package:chefaa/features/patient/medication/data/model/adherence_history.dart';

class Medication {
  Medication({
    this.name,
    this.dosage,
    this.form,
    this.timesPerDay,
    this.schedule,
    this.startDate,
    this.endDate,
    this.isActive,
    this.id,
    this.adherenceHistory,
  });

  Medication.fromJson(dynamic json) {
    name = json['name'];
    dosage = json['dosage'];
    form = json['form'];
    timesPerDay = json['timesPerDay'];
    schedule = json['schedule'] != null ? json['schedule'].cast<String>() : [];
    startDate = json['startDate'];
    endDate = json['endDate'];
    isActive = json['isActive'];
    id = json['_id'];
    if (json['adherenceHistory'] != null) {
      adherenceHistory = [];
      json['adherenceHistory'].forEach((v) {
        adherenceHistory?.add(AdherenceHistory.fromJson(v));
      });
    }
  }

  String? name;
  String? dosage;
  String? form;
  num? timesPerDay;
  List<String>? schedule;
  String? startDate;
  String? endDate;
  bool? isActive;
  String? id;
  List<AdherenceHistory>? adherenceHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['dosage'] = dosage;
    map['form'] = form;
    map['timesPerDay'] = timesPerDay;
    map['schedule'] = schedule;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['isActive'] = isActive;
    map['_id'] = id;
    if (adherenceHistory != null) {
      map['adherenceHistory'] = adherenceHistory
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }
}
