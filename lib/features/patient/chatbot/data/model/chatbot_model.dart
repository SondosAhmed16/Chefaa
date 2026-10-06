import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class ChatbotModel {
  bool? success;
  Data? data;

  ChatbotModel({this.success, this.data});

  @override
  String toString() => 'ChatbotModel(success: $success, data: $data)';

  factory ChatbotModel.fromMap(Map<String, dynamic> data) => ChatbotModel(
    success: data['success'] as bool?,
    data: data['data'] == null
        ? null
        : Data.fromMap(data['data'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {'success': success, 'data': data?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ChatbotModel].
  factory ChatbotModel.fromJson(String data) {
    return ChatbotModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ChatbotModel] to a JSON string.
  String toJson() => json.encode(toMap());

  ChatbotModel copyWith({bool? success, Data? data}) {
    return ChatbotModel(
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ChatbotModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode;
}
