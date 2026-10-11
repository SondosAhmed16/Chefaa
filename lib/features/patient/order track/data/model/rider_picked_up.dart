import 'dart:convert';

import 'package:collection/collection.dart';

class RiderPickedUp {
  String? title;
  String? description;
  dynamic time;
  bool? isCompleted;

  RiderPickedUp({this.title, this.description, this.time, this.isCompleted});

  @override
  String toString() {
    return 'RiderPickedUp(title: $title, description: $description, time: $time, isCompleted: $isCompleted)';
  }

  factory RiderPickedUp.fromMap(Map<String, dynamic> data) => RiderPickedUp(
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
  /// Parses the string and returns the resulting Json object as [RiderPickedUp].
  factory RiderPickedUp.fromJson(String data) {
    return RiderPickedUp.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [RiderPickedUp] to a JSON string.
  String toJson() => json.encode(toMap());

  RiderPickedUp copyWith({
    String? title,
    String? description,
    dynamic time,
    bool? isCompleted,
  }) {
    return RiderPickedUp(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RiderPickedUp) return false;
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
