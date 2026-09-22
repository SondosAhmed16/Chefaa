import 'dart:convert';

import 'package:collection/collection.dart';

import 'datum.dart';

class AppointmentModel {
  bool? success;
  int? count;
  List<Datum>? data;

  AppointmentModel({this.success, this.count, this.data});

  @override
  String toString() {
    return 'AppointmentModel(success: $success, count: $count, data: $data)';
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> data) => AppointmentModel(
    success: data['success'] as bool?,
    count: data['count'] as int?,
    data: (data['data'] as List<dynamic>?)
        ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'success': success,
    'count': count,
    'data': data?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AppointmentModel].
  factory AppointmentModel.fromJson(String data) {
    return AppointmentModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AppointmentModel] to a JSON string.
  String toJson() => json.encode(toMap());

  AppointmentModel copyWith({bool? success, int? count, List<Datum>? data}) {
    return AppointmentModel(
      success: success ?? this.success,
      count: count ?? this.count,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AppointmentModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ count.hashCode ^ data.hashCode;
}
