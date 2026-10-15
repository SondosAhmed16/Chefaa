import 'dart:convert';

import 'package:collection/collection.dart';

import 'service.dart';

class ToggleServiceModel {
  bool? success;
  String? message;
  Service? service;

  ToggleServiceModel({this.success, this.message, this.service});

  @override
  String toString() {
    return 'ToggleServiceModel(success: $success, message: $message, service: $service)';
  }

  factory ToggleServiceModel.fromMap(Map<String, dynamic> data) {
    return ToggleServiceModel(
      success: data['success'] as bool?,
      message: data['message'] as String?,
      service: data['service'] == null
          ? null
          : Service.fromMap(data['service'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'message': message,
    'service': service?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ToggleServiceModel].
  factory ToggleServiceModel.fromJson(String data) {
    return ToggleServiceModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ToggleServiceModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ToggleServiceModel copyWith({
    bool? success,
    String? message,
    Service? service,
  }) {
    return ToggleServiceModel(
      success: success ?? this.success,
      message: message ?? this.message,
      service: service ?? this.service,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ToggleServiceModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ message.hashCode ^ service.hashCode;
}
