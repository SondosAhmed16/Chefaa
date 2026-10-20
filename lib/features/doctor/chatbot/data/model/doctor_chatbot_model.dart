import 'dart:convert';

import 'package:collection/collection.dart';

import 'usage.dart';

class DoctorChatbotModel {
  String? reply;
  Usage? usage;

  DoctorChatbotModel({this.reply, this.usage});

  @override
  String toString() => 'DoctorChatbotModel(reply: $reply, usage: $usage)';

  factory DoctorChatbotModel.fromMap(Map<String, dynamic> data) {
    return DoctorChatbotModel(
      reply: data['reply'] as String?,
      usage: data['usage'] == null
          ? null
          : Usage.fromMap(data['usage'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {'reply': reply, 'usage': usage?.toMap()};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DoctorChatbotModel].
  factory DoctorChatbotModel.fromJson(String data) {
    return DoctorChatbotModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [DoctorChatbotModel] to a JSON string.
  String toJson() => json.encode(toMap());

  DoctorChatbotModel copyWith({String? reply, Usage? usage}) {
    return DoctorChatbotModel(
      reply: reply ?? this.reply,
      usage: usage ?? this.usage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DoctorChatbotModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => reply.hashCode ^ usage.hashCode;
}
