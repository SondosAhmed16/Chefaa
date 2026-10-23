import 'dart:convert';

import 'package:collection/collection.dart';

class UserId {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;

  UserId({this.id, this.name, this.email, this.phoneNumber});

  @override
  String toString() {
    return 'UserId(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber)';
  }

  factory UserId.fromMap(Map<String, dynamic> data) => UserId(
    id: data['_id'] as String?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    phoneNumber: data['phoneNumber'] as String?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
  };

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

  UserId copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return UserId(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! UserId) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ phoneNumber.hashCode;
}
