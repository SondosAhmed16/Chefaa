import 'dart:convert';

import 'package:collection/collection.dart';

class PharmacyPreparing {
  String? title;
  String? description;
  dynamic time;
  bool? isCompleted;

  PharmacyPreparing({
    this.title,
    this.description,
    this.time,
    this.isCompleted,
  });

  @override
  String toString() {
    return 'PharmacyPreparing(title: $title, description: $description, time: $time, isCompleted: $isCompleted)';
  }

  factory PharmacyPreparing.fromMap(Map<String, dynamic> data) {
    return PharmacyPreparing(
      title: data['title'] as String?,
      description: data['description'] as String?,
      time: data['time'] as dynamic,
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
  /// Parses the string and returns the resulting Json object as [PharmacyPreparing].
  factory PharmacyPreparing.fromJson(String data) {
    return PharmacyPreparing.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PharmacyPreparing] to a JSON string.
  String toJson() => json.encode(toMap());

  PharmacyPreparing copyWith({
    String? title,
    String? description,
    dynamic time,
    bool? isCompleted,
  }) {
    return PharmacyPreparing(
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PharmacyPreparing) return false;
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
