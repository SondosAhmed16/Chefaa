import 'dart:convert';

import 'package:collection/collection.dart';

import 'profile_data.dart';

class PharmacyProfileModel {
  bool? success;
  Data? data;

  PharmacyProfileModel({this.success, this.data});

  @override
  String toString() {
    return 'PharmacyProfileModel(success: $success, data: $data)';
  }

  factory PharmacyProfileModel.fromMap(Map<String, dynamic> data) {
    return PharmacyProfileModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PharmacyProfileModel].
  factory PharmacyProfileModel.fromJson(String data) {
    return PharmacyProfileModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [PharmacyProfileModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PharmacyProfileModel copyWith({bool? success, Data? data}) {
    return PharmacyProfileModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PharmacyProfileModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
