import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class GetStockModel {
  bool? success;
  Data? data;

  GetStockModel({this.success, this.data});

  @override
  String toString() => 'GetStockModel(success: $success, data: $data)';

  factory GetStockModel.fromMap(Map<String, dynamic> data) => GetStockModel(
    success: data['success'] as bool?,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetStockModel].
  factory GetStockModel.fromJson(String data) {
    return GetStockModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetStockModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetStockModel copyWith({bool? success, Data? data}) {
    return GetStockModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetStockModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
