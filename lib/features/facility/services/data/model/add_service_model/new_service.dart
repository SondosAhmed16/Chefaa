import 'dart:convert';

import 'package:collection/collection.dart';

class NewService {
  String? labId;
  String? name;
  String? category;
  int? price;
  String? estimatedTime;
  String? instructions;
  String? sessionDuration;
  String? imageUrl;
  bool? isActive;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  NewService({
    this.labId,
    this.name,
    this.category,
    this.price,
    this.estimatedTime,
    this.instructions,
    this.sessionDuration,
    this.imageUrl,
    this.isActive,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'NewService(labId: $labId, name: $name, category: $category, price: $price, estimatedTime: $estimatedTime, instructions: $instructions, sessionDuration: $sessionDuration, imageUrl: $imageUrl, isActive: $isActive, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory NewService.fromMap(Map<String, dynamic> data) => NewService(
    labId: data['labId'] as String?,
    name: data['name'] as String?,
    category: data['category'] as String?,
    price: data['price'] as int?,
    estimatedTime: data['estimatedTime'] as String?,
    instructions: data['instructions'] as String?,
    sessionDuration: data['sessionDuration'] as String?,
    imageUrl: data['imageUrl'] as String?,
    isActive: data['isActive'] as bool?,
    id: data['_id'] as String?,
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'labId': labId,
    'name': name,
    'category': category,
    'price': price,
    'estimatedTime': estimatedTime,
    'instructions': instructions,
    'sessionDuration': sessionDuration,
    'imageUrl': imageUrl,
    'isActive': isActive,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [NewService].
  factory NewService.fromJson(String data) {
    return NewService.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [NewService] to a JSON string.
  String toJson() => json.encode(toMap());

  NewService copyWith({
    String? labId,
    String? name,
    String? category,
    int? price,
    String? estimatedTime,
    String? instructions,
    String? sessionDuration,
    String? imageUrl,
    bool? isActive,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return NewService(
      labId: labId ?? this.labId,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      instructions: instructions ?? this.instructions,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! NewService) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      labId.hashCode ^
      name.hashCode ^
      category.hashCode ^
      price.hashCode ^
      estimatedTime.hashCode ^
      instructions.hashCode ^
      sessionDuration.hashCode ^
      imageUrl.hashCode ^
      isActive.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
