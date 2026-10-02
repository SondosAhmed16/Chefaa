import 'dart:convert';

import 'package:collection/collection.dart';

import 'available_tag.dart';

class CenterModel {
  String? labId;
  String? name;
  String? facilityType;
  double? rating;
  dynamic distanceNum;
  String? distance;
  bool? homeServiceAvailable;
  bool? insuranceAccepted;
  int? minPrice;
  String? badge;
  String? nextSlot;
  List<AvailableTag>? availableTags;

  CenterModel({
    this.labId,
    this.name,
    this.facilityType,
    this.rating,
    this.distanceNum,
    this.distance,
    this.homeServiceAvailable,
    this.insuranceAccepted,
    this.minPrice,
    this.badge,
    this.nextSlot,
    this.availableTags,
  });

  @override
  String toString() {
    return 'CenterModel(labId: $labId, name: $name, facilityType: $facilityType, rating: $rating, distanceNum: $distanceNum, distance: $distance, homeServiceAvailable: $homeServiceAvailable, insuranceAccepted: $insuranceAccepted, minPrice: $minPrice, badge: $badge, nextSlot: $nextSlot, availableTags: $availableTags)';
  }

  factory CenterModel.fromMap(Map<String, dynamic> data) => CenterModel(
    labId: data['labId'] as String?,
    name: data['name'] as String?,
    facilityType: data['facilityType'] as String?,
    rating: (data['rating'] as num?)?.toDouble(),
    distanceNum: data['distanceNum'] as dynamic,
    distance: data['distance'] as String?,
    homeServiceAvailable: data['homeServiceAvailable'] as bool?,
    insuranceAccepted: data['insuranceAccepted'] as bool?,
    minPrice: data['minPrice'] as int?,
    badge: data['badge'] as String?,
    nextSlot: data['nextSlot'] as String?,
    availableTags: (data['availableTags'] as List<dynamic>?)
        ?.map((e) => AvailableTag.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'labId': labId,
    'name': name,
    'facilityType': facilityType,
    'rating': rating,
    'distanceNum': distanceNum,
    'distance': distance,
    'homeServiceAvailable': homeServiceAvailable,
    'insuranceAccepted': insuranceAccepted,
    'minPrice': minPrice,
    'badge': badge,
    'nextSlot': nextSlot,
    'availableTags': availableTags?.map((e) => e.toMap()).toList(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CenterModel].
  factory CenterModel.fromJson(String data) {
    return CenterModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CenterModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CenterModel copyWith({
    String? labId,
    String? name,
    String? facilityType,
    double? rating,
    dynamic distanceNum,
    String? distance,
    bool? homeServiceAvailable,
    bool? insuranceAccepted,
    int? minPrice,
    String? badge,
    String? nextSlot,
    List<AvailableTag>? availableTags,
  }) {
    return CenterModel(
      labId: labId ?? this.labId,
      name: name ?? this.name,
      facilityType: facilityType ?? this.facilityType,
      rating: rating ?? this.rating,
      distanceNum: distanceNum ?? this.distanceNum,
      distance: distance ?? this.distance,
      homeServiceAvailable: homeServiceAvailable ?? this.homeServiceAvailable,
      insuranceAccepted: insuranceAccepted ?? this.insuranceAccepted,
      minPrice: minPrice ?? this.minPrice,
      badge: badge ?? this.badge,
      nextSlot: nextSlot ?? this.nextSlot,
      availableTags: availableTags ?? this.availableTags,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CenterModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      labId.hashCode ^
      name.hashCode ^
      facilityType.hashCode ^
      rating.hashCode ^
      distanceNum.hashCode ^
      distance.hashCode ^
      homeServiceAvailable.hashCode ^
      insuranceAccepted.hashCode ^
      minPrice.hashCode ^
      badge.hashCode ^
      nextSlot.hashCode ^
      availableTags.hashCode;
}
