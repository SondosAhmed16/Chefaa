import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class GetOrdersModel {
  bool? success;
  Data? data;

  GetOrdersModel({this.success, this.data});

  @override
  String toString() => 'GetOrdersModel(success: $success, data: $data)';

  factory GetOrdersModel.fromMap(Map<String, dynamic> data) {
    return GetOrdersModel(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetOrdersModel].
  factory GetOrdersModel.fromJson(String data) {
    return GetOrdersModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetOrdersModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetOrdersModel copyWith({bool? success, Data? data}) {
    return GetOrdersModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetOrdersModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
