import 'dart:convert';

import 'package:collection/collection.dart';

import '../paied_appointment_model/data.dart';

class CompletedAppointmentModel {
  bool? success;
  String? message;
  Data? data;

  CompletedAppointmentModel({this.success, this.message, this.data});

  @override
  String toString() {
    return 'CompletedAppointmentModel(success: $success, message: $message, data: $data)';
  }

  factory CompletedAppointmentModel.fromMap(Map<String, dynamic> data) {
    return CompletedAppointmentModel(
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
  /// Parses the string and returns the resulting Json object as [CompletedAppointmentModel].
  factory CompletedAppointmentModel.fromJson(String data) {
    return CompletedAppointmentModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [CompletedAppointmentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CompletedAppointmentModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) {
    return CompletedAppointmentModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CompletedAppointmentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ data.hashCode;
}
