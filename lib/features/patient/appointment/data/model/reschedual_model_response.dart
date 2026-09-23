import 'dart:convert';

import 'package:chefaa/features/patient/appointment/data/model/datum.dart';
import 'package:collection/collection.dart';

class ReschedualModelResponse {
  bool? success;
  String? message;
  Datum? data;

  ReschedualModelResponse({this.success, this.message, this.data});

  @override
  String toString() {
    return 'ReschedualModelResponse(success: $success, message: $message, data: $data)';
  }

  factory ReschedualModelResponse.fromMap(Map<String, dynamic> data) {
    return ReschedualModelResponse(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      data: (data['data'] != null && data['data'] is Map<String, dynamic>)
          ? Datum.fromMap(data['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'data': data?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ReschedualModel].
  factory ReschedualModelResponse.fromJson(String data) {
    return ReschedualModelResponse.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ReschedualModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ReschedualModelResponse copyWith({
    bool? success,
    String? message,
    Datum? data,
  }) {
    return ReschedualModelResponse(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ReschedualModelResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
