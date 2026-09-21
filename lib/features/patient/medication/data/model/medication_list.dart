import 'package:chefaa/features/patient/medication/data/model/stats_model.dart';

import 'medications.dart';

class MedicationList {
  MedicationList({this.stats, this.medications});

  MedicationList.fromJson(dynamic json) {
    stats = json['stats'] != null ? Stats.fromJson(json['stats']) : null;
    if (json['medications'] != null) {
      medications = [];
      json['medications'].forEach((v) {
        medications?.add(Medications.fromJson(v));
      });
    }
  }

  Stats? stats;
  List<Medications>? medications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stats != null) {
      map['stats'] = stats?.toJson();
    }
    if (medications != null) {
      map['medications'] = medications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  MedicationList copyWith({Stats? stats, List<Medications>? medications}) {
    return MedicationList(
      stats: stats ?? this.stats,
      medications: medications ?? this.medications,
    );
  }
}
