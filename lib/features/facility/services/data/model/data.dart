import 'dart:convert';

import 'package:collection/collection.dart';

import 'lab_test.dart';

class Data {
  List<LabTest>? labTests;
  List<dynamic>? radiology;

  Data({this.labTests, this.radiology});

  @override
  String toString() => 'Data(labTests: $labTests, radiology: $radiology)';

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    labTests: (data['labTests'] as List<dynamic>?)
        ?.map((e) => LabTest.fromMap(e as Map<String, dynamic>))
        .toList(),
    radiology: data['radiology'] as List<dynamic>?,
  );

  Map<String, dynamic> toMap() => {
    'labTests': labTests?.map((e) => e.toMap()).toList(),
    'radiology': radiology,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({List<LabTest>? labTests, List<dynamic>? radiology}) {
    return Data(
      labTests: labTests ?? this.labTests,
      radiology: radiology ?? this.radiology,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => labTests.hashCode ^ radiology.hashCode;
}
