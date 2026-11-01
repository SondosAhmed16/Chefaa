import 'dart:convert';

import 'package:collection/collection.dart';

class UserId {
  String? id;
  String? name;

  UserId({this.id, this.name});

  @override
  String toString() => 'UserId(id: $id, name: $name)';

  factory UserId.fromMap(Map<String, dynamic> data) =>
      UserId(id: data['_id'] as String?, name: data['name'] as String?);

  Map<String, dynamic> toMap() => {'_id': id, 'name': name};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserId].
  factory UserId.fromJson(String data) {
    return UserId.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserId] to a JSON string.
  String toJson() => json.encode(toMap());

  UserId copyWith({String? id, String? name}) {
    return UserId(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserId) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
