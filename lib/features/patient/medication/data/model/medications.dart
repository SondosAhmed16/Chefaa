import 'adherence_history.dart';

class Medications {
  Medications({
    this.id,
    this.name,
    this.dosage,
    this.form,
    this.timesPerDay,
    this.schedule,
    this.startDate,
    this.endDate,
    this.isActive,
    this.adherencePercentage,
    this.adherenceHistory,
  });

  Medications.fromJson(dynamic json) {
    id = json['_id']?.toString();
    name = json['name']?.toString();
    dosage = json['dosage']?.toString();
    form = json['form']?.toString();

    timesPerDay = json['timesPerDay'] is num
        ? json['timesPerDay']
        : num.tryParse(json['timesPerDay']?.toString() ?? '');
    adherencePercentage = json['adherencePercentage'] is num
        ? json['adherencePercentage']
        : num.tryParse(json['adherencePercentage']?.toString() ?? '');

    if (json['schedule'] != null) {
      schedule = List<String>.from(json['schedule'].map((x) => x.toString()));
    } else {
      schedule = [];
    }

    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    isActive = json['isActive'] is bool
        ? json['isActive']
        : (json['isActive']?.toString() == 'true');

    if (json['adherenceHistory'] != null) {
      adherenceHistory = [];
      json['adherenceHistory'].forEach((v) {
        adherenceHistory?.add(AdherenceHistory.fromJson(v));
      });
    }
  }

  String? id;
  String? name;
  String? dosage;
  String? form;
  num? timesPerDay;
  List<String>? schedule;
  String? startDate;
  String? endDate;
  bool? isActive;
  num? adherencePercentage;
  List<AdherenceHistory>? adherenceHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['dosage'] = dosage;
    map['form'] = form;
    map['timesPerDay'] = timesPerDay;
    map['schedule'] = schedule;
    map['startDate'] = startDate;
    map['endDate'] = endDate;
    map['isActive'] = isActive;
    map['adherencePercentage'] = adherencePercentage;
    if (adherenceHistory != null) {
      map['adherenceHistory'] = adherenceHistory
          ?.map((v) => v.toJson())
          .toList();
    }
    return map;
  }

  Medications copyWith({
    String? id,
    String? name,
    String? dosage,
    String? form,
    num? timesPerDay,
    List<String>? schedule,
    String? startDate,
    String? endDate,
    bool? isActive,
    num? adherencePercentage,
    List<AdherenceHistory>? adherenceHistory,
  }) {
    return Medications(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      form: form ?? this.form,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      schedule: schedule ?? this.schedule,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      adherencePercentage: adherencePercentage ?? this.adherencePercentage,
      adherenceHistory: adherenceHistory ?? this.adherenceHistory,
    );
  }

  num? get calculatedAdherence {
    if (adherencePercentage != null) return adherencePercentage;

    if (adherenceHistory == null || adherenceHistory!.isEmpty) {
      return null;
    }

    int takenDoses = adherenceHistory!.where((h) => h.status == 'taken').length;

    return ((takenDoses / adherenceHistory!.length) * 100).round();
  }
}
