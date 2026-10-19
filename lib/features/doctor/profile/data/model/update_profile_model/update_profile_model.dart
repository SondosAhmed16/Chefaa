import 'dart:convert';

import 'package:collection/collection.dart';

import 'doctor.dart';

class UpdateProfileModel {
  String? message;
  Doctor? doctor;

  UpdateProfileModel({this.message, this.doctor});

  @override
  String toString() {
    return 'UpdateProfileModel(message: $message, doctor: $doctor)';
  }

  factory UpdateProfileModel.fromMap(Map<String, dynamic> data) {
    return UpdateProfileModel(
      message: data['message'] as String?,
      doctor: data['doctor'] == null
          ? null
          : Doctor.fromMap(data['doctor'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'message': message,
    'doctor': doctor?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UpdateProfileModel].
  factory UpdateProfileModel.fromJson(String data) {
    return UpdateProfileModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [UpdateProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());

  UpdateProfileModel copyWith({String? message, Doctor? doctor}) {
    return UpdateProfileModel(
      message: message ?? this.message,
      doctor: doctor ?? this.doctor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UpdateProfileModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => message.hashCode ^ doctor.hashCode;
}
