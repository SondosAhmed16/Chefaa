import 'dart:convert';

import 'package:collection/collection.dart';

import 'conversation_history.dart';
import 'usage.dart';

class Data {
  String? reply;
  List<ConversationHistory>? conversationHistory;
  Usage? usage;

  Data({this.reply, this.conversationHistory, this.usage});

  @override
  String toString() {
    return 'Data(reply: $reply, conversationHistory: $conversationHistory, usage: $usage)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    reply: data['reply'] as String?,
    conversationHistory: (data['conversationHistory'] as List<dynamic>?)
        ?.map((e) => ConversationHistory.fromMap(e as Map<String, dynamic>))
        .toList(),
    usage: data['usage'] == null
        ? null
        : Usage.fromMap(data['usage'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'reply': reply,
    'conversationHistory': conversationHistory?.map((e) => e.toMap()).toList(),
    'usage': usage?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? reply,
    List<ConversationHistory>? conversationHistory,
    Usage? usage,
  }) {
    return Data(
      reply: reply ?? this.reply,
      conversationHistory: conversationHistory ?? this.conversationHistory,
      usage: usage ?? this.usage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      reply.hashCode ^ conversationHistory.hashCode ^ usage.hashCode;
}
