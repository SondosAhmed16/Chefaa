import 'dart:convert';

import 'package:collection/collection.dart';

class AvailableTag {
  String? name;
  String? category;
  bool? isPartner;

  AvailableTag({this.name, this.category, this.isPartner});

  @override
  String toString() {
    return 'AvailableTag(name: $name, category: $category, isPartner: $isPartner)';
  }

  factory AvailableTag.fromMap(Map<String, dynamic> data) => AvailableTag(
    name: data['name'] as String?,
    category: data['category'] as String?,
    isPartner: data['isPartner'] as bool?,
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'isPartner': isPartner,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AvailableTag].
  factory AvailableTag.fromJson(String data) {
    return AvailableTag.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AvailableTag] to a JSON string.
  String toJson() => json.encode(toMap());

  AvailableTag copyWith({String? name, String? category, bool? isPartner}) {
    return AvailableTag(
      name: name ?? this.name,
      category: category ?? this.category,
      isPartner: isPartner ?? this.isPartner,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! AvailableTag) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => name.hashCode ^ category.hashCode ^ isPartner.hashCode;
}
