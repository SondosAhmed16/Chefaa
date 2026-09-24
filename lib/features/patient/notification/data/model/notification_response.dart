import 'dart:convert';

import 'package:collection/collection.dart';

class NotificationResponse {
  String? id;
  String? recipient;
  String? title;
  String? message;
  String? type;
  bool? isRead;
  DateTime? createdAt;
  int? v;

  NotificationResponse({
    this.id,
    this.recipient,
    this.title,
    this.message,
    this.type,
    this.isRead,
    this.createdAt,
    this.v,
  });

  @override
  String toString() {
    return 'NotificationResponse(id: $id, recipient: $recipient, title: $title, message: $message, type: $type, isRead: $isRead, createdAt: $createdAt, v: $v)';
  }

  factory NotificationResponse.fromMap(Map<String, dynamic> data) {
    return NotificationResponse(
      id: data['_id'] as String?,
      recipient: data['recipient'] as String?,
      title: data['title'] as String?,
      message: data['message'] as String?,
      type: data['type'] as String?,
      isRead: data['isRead'] as bool?,
      createdAt: data['createdAt'] == null
          ? null
          : DateTime.parse(data['createdAt'] as String),
      v: data['__v'] as int?,
    );
  }

  static List<NotificationResponse> fromJsonList(List<dynamic> jsonList) {
  return jsonList
      .map((item) => NotificationResponse.fromMap(item as Map<String, dynamic>))
      .toList();
}

  Map<String, dynamic> toMap() => {
    '_id': id,
    'recipient': recipient,
    'title': title,
    'message': message,
    'type': type,
    'isRead': isRead,
    'createdAt': createdAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NotificationResponse].
  factory NotificationResponse.fromJson(String data) {
    return NotificationResponse.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  /// `dart:convert`
  ///
  /// Converts [NotificationResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  NotificationResponse copyWith({
    String? id,
    String? recipient,
    String? title,
    String? message,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    int? v,
  }) {
    return NotificationResponse(
      id: id ?? this.id,
      recipient: recipient ?? this.recipient,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NotificationResponse) return false;
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
      isRead.hashCode ^
      createdAt.hashCode ^
      v.hashCode;
}
