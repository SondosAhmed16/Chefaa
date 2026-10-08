import 'dart:convert';

import 'package:collection/collection.dart';

import 'location.dart';
import 'working_hour.dart';

class Data {
  String? id;
  String? pharmacyName;
  bool? openNow;
  bool? alwaysOpen;
  int? rating;
  int? totalReviews;
  String? deliveryTime;
  int? deliveryFee;
  int? minimumOrder;
  String? phone;
  String? about;
  List<dynamic>? services;
  List<WorkingHour>? workingHours;
  String? addressText;
  Location? location;
  int? availableMedicinesCount;

  Data({
    this.id,
    this.pharmacyName,
    this.openNow,
    this.alwaysOpen,
    this.rating,
    this.totalReviews,
    this.deliveryTime,
    this.deliveryFee,
    this.minimumOrder,
    this.phone,
    this.about,
    this.services,
    this.workingHours,
    this.addressText,
    this.location,
    this.availableMedicinesCount,
  });

  @override
  String toString() {
    return 'Data(id: $id, pharmacyName: $pharmacyName, openNow: $openNow, alwaysOpen: $alwaysOpen, rating: $rating, totalReviews: $totalReviews, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, minimumOrder: $minimumOrder, phone: $phone, about: $about, services: $services, workingHours: $workingHours, addressText: $addressText, location: $location, availableMedicinesCount: $availableMedicinesCount)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    id: data['_id'] as String?,
    pharmacyName: data['pharmacyName'] as String?,
    openNow: data['openNow'] as bool?,
    alwaysOpen: data['alwaysOpen'] as bool?,
    rating: data['rating'] as int?,
    totalReviews: data['totalReviews'] as int?,
    deliveryTime: data['deliveryTime'] as String?,
    deliveryFee: data['deliveryFee'] as int?,
    minimumOrder: data['minimumOrder'] as int?,
    phone: data['phone'] as String?,
    about: data['about'] as String?,
    services: data['services'] as List<dynamic>?,
    workingHours: (data['workingHours'] as List<dynamic>?)
        ?.map((e) => WorkingHour.fromMap(e as Map<String, dynamic>))
        .toList(),
    addressText: data['addressText'] as String?,
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    availableMedicinesCount: data['availableMedicinesCount'] as int?,
  );

  Map<String, dynamic> toMap() => {
    '_id': id,
    'pharmacyName': pharmacyName,
    'openNow': openNow,
    'alwaysOpen': alwaysOpen,
    'rating': rating,
    'totalReviews': totalReviews,
    'deliveryTime': deliveryTime,
    'deliveryFee': deliveryFee,
    'minimumOrder': minimumOrder,
    'phone': phone,
    'about': about,
    'services': services,
    'workingHours': workingHours?.map((e) => e.toMap()).toList(),
    'addressText': addressText,
    'location': location?.toMap(),
    'availableMedicinesCount': availableMedicinesCount,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    String? id,
    String? pharmacyName,
    bool? openNow,
    bool? alwaysOpen,
    int? rating,
    int? totalReviews,
    String? deliveryTime,
    int? deliveryFee,
    int? minimumOrder,
    String? phone,
    String? about,
    List<dynamic>? services,
    List<WorkingHour>? workingHours,
    String? addressText,
    Location? location,
    int? availableMedicinesCount,
  }) {
    return Data(
      id: id ?? this.id,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      openNow: openNow ?? this.openNow,
      alwaysOpen: alwaysOpen ?? this.alwaysOpen,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      services: services ?? this.services,
      workingHours: workingHours ?? this.workingHours,
      addressText: addressText ?? this.addressText,
      location: location ?? this.location,
      availableMedicinesCount:
          availableMedicinesCount ?? this.availableMedicinesCount,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      pharmacyName.hashCode ^
      openNow.hashCode ^
      alwaysOpen.hashCode ^
      rating.hashCode ^
      totalReviews.hashCode ^
      deliveryTime.hashCode ^
      deliveryFee.hashCode ^
      minimumOrder.hashCode ^
      phone.hashCode ^
      about.hashCode ^
      services.hashCode ^
      workingHours.hashCode ^
      addressText.hashCode ^
      location.hashCode ^
      availableMedicinesCount.hashCode;
}
