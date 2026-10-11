import 'dart:convert';

import 'package:collection/collection.dart';

class OrderConfirmed {
  String? title;
  String? description;
  String? time;
  bool? isCompleted;

  OrderConfirmed({this.title, this.description, this.time, this.isCompleted});

  @override
  String toString() {
    return 'OrderConfirmed(title: $title, description: $description, time: $time, isCompleted: $isCompleted)';
  }

  factory OrderConfirmed.fromMap(Map<String, dynamic> data) {
    return OrderConfirmed(
      title: data['title'] as String?,
      description: data['description'] as String?,
      time: data['time'] as String?,
      isCompleted: data['isCompleted'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'time': time,
    'isCompleted': isCompleted,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderConfirmed].
  factory OrderConfirmed.fromJson(String data) {
    return OrderConfirmed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderConfirmed] to a JSON string.
  String toJson() => json.encode(toMap());

  OrderConfirmed copyWith({
    String? title,
    String? description,
    String? time,
    bool? isCompleted,
  }) {
    return OrderConfirmed(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderConfirmed) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      title.hashCode ^
      description.hashCode ^
      time.hashCode ^
      isCompleted.hashCode;
}
