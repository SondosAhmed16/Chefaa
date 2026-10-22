import 'dart:convert';

import 'package:collection/collection.dart';

import 'clinic.dart';

class ClinicModel {
  String? message;
  Clinic? clinic;

  ClinicModel({this.message, this.clinic});

  @override
  String toString() {
    return 'ClinicModel(message: $message, clinic: $clinic, )';
  }

  factory ClinicModel.fromMap(Map<String, dynamic> data) => ClinicModel(
    message: data['message'] as String?,
    clinic: data['clinic'] == null
        ? null
        : Clinic.fromMap(data['clinic'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'message': message,
    'clinic': clinic?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ClinicModel].
  factory ClinicModel.fromJson(String data) {
    return ClinicModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ClinicModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ClinicModel copyWith({String? message, Clinic? clinic}) {
    return ClinicModel(
      message: message ?? this.message,
      clinic: clinic ?? this.clinic,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ClinicModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }
}
