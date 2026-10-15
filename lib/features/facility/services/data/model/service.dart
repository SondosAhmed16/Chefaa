import 'dart:convert';

import 'package:collection/collection.dart';

class Service {
  String? id;
  String? labId;
  String? name;
  String? category;
  int? price;
  String? estimatedTime;
  String? instructions;
  String? sessionDuration;
  String? imageUrl;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Service({
    this.id,
    this.labId,
    this.name,
    this.category,
    this.price,
    this.estimatedTime,
    this.instructions,
    this.sessionDuration,
    this.imageUrl,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Service(id: $id, labId: $labId, name: $name, category: $category, price: $price, estimatedTime: $estimatedTime, instructions: $instructions, sessionDuration: $sessionDuration, imageUrl: $imageUrl, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Service.fromMap(Map<String, dynamic> data) => Service(
    id: data['_id'] as String?,
    labId: data['labId'] as String?,
    name: data['name'] as String?,
    category: data['category'] as String?,
    price: data['price'] as int?,
    estimatedTime: data['estimatedTime'] as String?,
    instructions: data['instructions'] as String?,
    sessionDuration: data['sessionDuration'] as String?,
    imageUrl: data['imageUrl'] as String?,
    isActive: data['isActive'] as bool?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'labId': labId,
    'name': name,
    'category': category,
    'price': price,
    'estimatedTime': estimatedTime,
    'instructions': instructions,
    'sessionDuration': sessionDuration,
    'imageUrl': imageUrl,
    'isActive': isActive,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Service].
  factory Service.fromJson(String data) {
    return Service.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Service] to a JSON string.
  String toJson() => json.encode(toMap());

  Service copyWith({
    String? id,
    String? labId,
    String? name,
    String? category,
    int? price,
    String? estimatedTime,
    String? instructions,
    String? sessionDuration,
    String? imageUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Service(
      id: id ?? this.id,
      labId: labId ?? this.labId,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      instructions: instructions ?? this.instructions,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Service) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      labId.hashCode ^
      name.hashCode ^
      category.hashCode ^
      price.hashCode ^
      estimatedTime.hashCode ^
      instructions.hashCode ^
      sessionDuration.hashCode ^
      imageUrl.hashCode ^
      isActive.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
