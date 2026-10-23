import 'dart:convert';

import 'package:collection/collection.dart';

import 'datum.dart';

class DoctorAppointmentModel {
  bool? success;
  int? count;
  List<Datum>? data;

  DoctorAppointmentModel({this.success, this.count, this.data});

  @override
  String toString() {
    return 'DoctorAppointmentModel(success: $success, count: $count, data: $data)';
  }

  factory DoctorAppointmentModel.fromMap(Map<String, dynamic> data) {
    return DoctorAppointmentModel(
      success: data['success'] as bool?,
      count: data['count'] as int?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
    'success': success,
    'count': count,
    'data': data?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorAppointmentModel].
  factory DoctorAppointmentModel.fromJson(String data) {
    return DoctorAppointmentModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorAppointmentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorAppointmentModel copyWith({
    bool? success,
    int? count,
    List<Datum>? data,
  }) {
    return DoctorAppointmentModel(
      success: success ?? this.success,
      count: count ?? this.count,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DoctorAppointmentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ count.hashCode ^ data.hashCode;
}
