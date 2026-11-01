import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class SettingsUpdat {
  bool? success;
  String? message;
  Data? data;

  SettingsUpdat({this.success, this.message, this.data});

  @override
  String toString() {
    return 'SettingsUpdat(success: $success, message: $message, data: $data)';
  }

  factory SettingsUpdat.fromMap(Map<String, dynamic> data) => SettingsUpdat(
    success: data['success'] as bool?,
    message: data['message'] as String?,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SettingsUpdat].
  factory SettingsUpdat.fromJson(String data) {
    return SettingsUpdat.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SettingsUpdat] to a JSON string.
  String toJson() => json.encode(toMap());

  SettingsUpdat copyWith({bool? success, String? message, Data? data}) {
    return SettingsUpdat(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SettingsUpdat) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
