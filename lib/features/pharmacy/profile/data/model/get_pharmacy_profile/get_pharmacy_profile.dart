import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class GetPharmacyProfile {
  bool? success;
  Data? data;

  GetPharmacyProfile({this.success, this.data});

  @override
  String toString() => 'GetPharmacyProfile(success: $success, data: $data)';

  factory GetPharmacyProfile.fromMap(Map<String, dynamic> data) {
    return GetPharmacyProfile(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetPharmacyProfile].
  factory GetPharmacyProfile.fromJson(String data) {
    return GetPharmacyProfile.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [GetPharmacyProfile] to a JSON string.
  String toJson() => json.encode(toMap());

  GetPharmacyProfile copyWith({bool? success, Data? data}) {
    return GetPharmacyProfile(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetPharmacyProfile) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
