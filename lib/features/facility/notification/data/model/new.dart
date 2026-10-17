import 'dart:convert';

import 'package:collection/collection.dart';

class New {
  String? id;
  String? recipient;
  String? title;
  String? message;
  String? type;
  String? relatedId;
  bool? isRead;
  DateTime? createdAt;
  int? v;

  New({
    this.id,
    this.recipient,
    this.title,
    this.message,
    this.type,
    this.relatedId,
    this.isRead,
    this.createdAt,
    this.v,
  });

  @override
  String toString() {
    return 'New(id: $id, recipient: $recipient, title: $title, message: $message, type: $type, relatedId: $relatedId, isRead: $isRead, createdAt: $createdAt, v: $v)';
  }

  factory New.fromMap(Map<String, dynamic> data) => New(
    id: data['_id'] as String?,
    recipient: data['recipient'] as String?,
    title: data['title'] as String?,
    message: data['message'] as String?,
    type: data['type'] as String?,
    relatedId: data['relatedId'] as String?,
    isRead: data['isRead'] as bool?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'recipient': recipient,
    'title': title,
    'message': message,
    'type': type,
    'relatedId': relatedId,
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [New].
  factory New.fromJson(String data) {
    return New.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [New] to a JSON string.
  String toJson() => json.encode(toMap());

  New copyWith({
    String? id,
    String? recipient,
    String? title,
    String? message,
    String? type,
    String? relatedId,
    bool? isRead,
    DateTime? createdAt,
    int? v,
  }) {
    return New(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      relatedId: relatedId ?? this.relatedId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! New) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      recipient.hashCode ^
      title.hashCode ^
      message.hashCode ^
      type.hashCode ^
      relatedId.hashCode ^
      isRead.hashCode ^
      createdAt.hashCode ^
      v.hashCode;
}
