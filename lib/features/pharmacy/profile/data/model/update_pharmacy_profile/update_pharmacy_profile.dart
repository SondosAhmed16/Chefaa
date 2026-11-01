import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class UpdatePharmacyProfile {
  bool? success;
  String? message;
  Data? data;

  UpdatePharmacyProfile({this.success, this.message, this.data});

  @override
  String toString() {
    return 'UpdatePharmacyProfile(success: $success, message: $message, data: $data)';
  }

  factory UpdatePharmacyProfile.fromMap(Map<String, dynamic> data) {
    return UpdatePharmacyProfile(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UpdatePharmacyProfile].
  factory UpdatePharmacyProfile.fromJson(String data) {
    return UpdatePharmacyProfile.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [UpdatePharmacyProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  UpdatePharmacyProfile copyWith({bool? success, String? message, Data? data}) {
    return UpdatePharmacyProfile(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UpdatePharmacyProfile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
