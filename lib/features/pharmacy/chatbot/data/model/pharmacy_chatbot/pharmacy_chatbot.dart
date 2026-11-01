import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class PharmacyChatbot {
  bool? success;
  Data? data;

  PharmacyChatbot({this.success, this.data});

  @override
  String toString() => 'PharmacyChatbot(success: $success, data: $data)';

  factory PharmacyChatbot.fromMap(Map<String, dynamic> data) {
    return PharmacyChatbot(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PharmacyChatbot].
  factory PharmacyChatbot.fromJson(String data) {
    return PharmacyChatbot.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PharmacyChatbot] to a JSON string.
  String toJson() => json.encode(toMap());

  PharmacyChatbot copyWith({bool? success, Data? data}) {
    return PharmacyChatbot(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PharmacyChatbot) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
