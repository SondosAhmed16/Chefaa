import 'dart:convert';

import 'package:collection/collection.dart';

class ConversationHistory {
  String? role;
  String? content;

  ConversationHistory({this.role, this.content});

  @override
  String toString() => 'ConversationHistory(role: $role, content: $content)';

  factory ConversationHistory.fromMap(Map<String, dynamic> data) {
    return ConversationHistory(
      role: data['role'] as String?,
      content: data['content'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {'role': role, 'content': content};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConversationHistory].
  factory ConversationHistory.fromJson(String data) {
    return ConversationHistory.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [ConversationHistory] to a JSON string.
  String toJson() => json.encode(toMap());

  ConversationHistory copyWith({String? role, String? content}) {
    return ConversationHistory(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConversationHistory) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => role.hashCode ^ content.hashCode;
}
