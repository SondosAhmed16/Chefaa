import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class OrderTrackModel {
  bool? success;
  Data? data;

  OrderTrackModel({this.success, this.data});

  @override
  String toString() => 'OrderTrackModel(success: $success, data: $data)';

  factory OrderTrackModel.fromMap(Map<String, dynamic> data) {
    return OrderTrackModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderTrackModel].
  factory OrderTrackModel.fromJson(String data) {
    return OrderTrackModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderTrackModel] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderTrackModel copyWith({bool? success, Data? data}) {
    return OrderTrackModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderTrackModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
