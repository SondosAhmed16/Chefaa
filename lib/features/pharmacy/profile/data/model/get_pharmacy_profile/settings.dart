import 'dart:convert';

import 'package:collection/collection.dart';

class Settings {
  bool? deliveryAvailable;
  bool? openNow;
  bool? prescriptionOnly;

  Settings({this.deliveryAvailable, this.openNow, this.prescriptionOnly});

  @override
  String toString() {
    return 'Settings(deliveryAvailable: $deliveryAvailable, openNow: $openNow, prescriptionOnly: $prescriptionOnly)';
  }

  factory Settings.fromMap(Map<String, dynamic> data) => Settings(
    deliveryAvailable: data['deliveryAvailable'] as bool?,
    openNow: data['openNow'] as bool?,
    prescriptionOnly: data['prescriptionOnly'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'deliveryAvailable': deliveryAvailable,
    'openNow': openNow,
    'prescriptionOnly': prescriptionOnly,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Settings].
  factory Settings.fromJson(String data) {
    return Settings.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Settings] to a JSON string.
  String toJson() => json.encode(toMap());

  Settings copyWith({
    bool? deliveryAvailable,
    bool? openNow,
    bool? prescriptionOnly,
  }) {
    return Settings(
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
      openNow: openNow ?? this.openNow,
      prescriptionOnly: prescriptionOnly ?? this.prescriptionOnly,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Settings) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      deliveryAvailable.hashCode ^ openNow.hashCode ^ prescriptionOnly.hashCode;
}
