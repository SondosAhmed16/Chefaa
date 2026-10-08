import 'dart:convert';

import 'package:collection/collection.dart';

class Address {
  String? addressText;
  String? id;

  Address({this.addressText, this.id});

  @override
  String toString() => 'Address(addressText: $addressText, id: $id)';

  factory Address.fromMap(Map<String, dynamic> data) => Address(
    addressText: data['addressText'] as String?,
    id: data['_id'] as String?,
  );

  Map<String, dynamic> toMap() => {'addressText': addressText, '_id': id};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Address].
  factory Address.fromJson(String data) {
    return Address.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Address] to a JSON string.
  String toJson() => json.encode(toMap());

  Address copyWith({String? addressText, String? id}) {
    return Address(
      addressText: addressText ?? this.addressText,
      id: id ?? this.id,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Address) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => addressText.hashCode ^ id.hashCode;
}
