import 'dart:convert';

import 'package:collection/collection.dart';

class OnTheWay {
  String? title;
  String? description;
  dynamic time;
  bool? isCompleted;

  OnTheWay({this.title, this.description, this.time, this.isCompleted});

  @override
  String toString() {
    return 'OnTheWay(title: $title, description: $description, time: $time, isCompleted: $isCompleted)';
  }

  factory OnTheWay.fromMap(Map<String, dynamic> data) => OnTheWay(
    title: data['title'] as String?,
    description: data['description'] as String?,
    time: data['time'] as dynamic,
    isCompleted: data['isCompleted'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'title': title,
    'description': description,
    'time': time,
    'isCompleted': isCompleted,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OnTheWay].
  factory OnTheWay.fromJson(String data) {
    return OnTheWay.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OnTheWay] to a JSON string.
  String toJson() => json.encode(toMap());

  OnTheWay copyWith({
    String? title,
    String? description,
    dynamic time,
    bool? isCompleted,
  }) {
    return OnTheWay(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OnTheWay) return false;
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
