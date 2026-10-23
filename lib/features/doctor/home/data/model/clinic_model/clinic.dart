import 'dart:convert';

import 'package:collection/collection.dart';

import 'default_schedule.dart';
import 'location.dart';

class Clinic {
  String? doctorId;
  String? name;
  String? city;
  String? address;
  Location? location;
  String? color;
  DefaultSchedule? defaultSchedule;
  int? price;
  String? operatingLicense;
  String? status;
  dynamic activatedAt;
  dynamic activatedBy;
  String? rejectionReason;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Clinic({
    this.doctorId,
    this.name,
    this.city,
    this.address,
    this.location,
    this.color,
    this.defaultSchedule,
    this.price,
    this.operatingLicense,
    this.status,
    this.activatedAt,
    this.activatedBy,
    this.rejectionReason,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  @override
  String toString() {
    return 'Clinic(doctorId: $doctorId, name: $name, city: $city, address: $address, location: $location, color: $color, defaultSchedule: $defaultSchedule, price: $price, operatingLicense: $operatingLicense, status: $status, activatedAt: $activatedAt, activatedBy: $activatedBy, rejectionReason: $rejectionReason, id: $id, createdAt: $createdAt, updatedAt: $updatedAt, v: $v)';
  }

  factory Clinic.fromMap(Map<String, dynamic> data) => Clinic(
    doctorId: data['doctorId'] as String?,
    name: data['name'] as String?,
    city: data['city'] as String?,
    address: data['address'] as String?,
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    color: data['color'] as String?,
    defaultSchedule: data['defaultSchedule'] == null
        ? null
        : DefaultSchedule.fromMap(
            data['defaultSchedule'] as Map<String, dynamic>,
          ),
    price: data['price'] != null ? (data['price'] as num).toInt() : null,
    operatingLicense: data['operatingLicense'] as String?,
    status: data['status'] as String?,
    activatedAt: data['activatedAt'] as dynamic,
    activatedBy: data['activatedBy'] as dynamic,
    rejectionReason: data['rejectionReason'] as String?,
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
    'doctorId': doctorId,
    'name': name,
    'city': city,
    'address': address,
    'location': location?.toMap(),
    'color': color,
    'defaultSchedule': defaultSchedule?.toMap(),
    'price': price,
    'operatingLicense': operatingLicense,
    'status': status,
    'activatedAt': activatedAt,
    'activatedBy': activatedBy,
    'rejectionReason': rejectionReason,
    '_id': id,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Clinic].
  factory Clinic.fromJson(String data) {
    return Clinic.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Clinic] to a JSON string.
  String toJson() => json.encode(toMap());

  Clinic copyWith({
    String? doctorId,
    String? name,
    String? city,
    String? address,
    Location? location,
    String? color,
    DefaultSchedule? defaultSchedule,
    int? price,
    String? operatingLicense,
    String? status,
    dynamic activatedAt,
    dynamic activatedBy,
    String? rejectionReason,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Clinic(
      doctorId: doctorId ?? this.doctorId,
      name: name ?? this.name,
      city: city ?? this.city,
      address: address ?? this.address,
      location: location ?? this.location,
      color: color ?? this.color,
      defaultSchedule: defaultSchedule ?? this.defaultSchedule,
      price: price ?? this.price,
      operatingLicense: operatingLicense ?? this.operatingLicense,
      status: status ?? this.status,
      activatedAt: activatedAt ?? this.activatedAt,
      activatedBy: activatedBy ?? this.activatedBy,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Clinic) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      doctorId.hashCode ^
      name.hashCode ^
      city.hashCode ^
      address.hashCode ^
      location.hashCode ^
      color.hashCode ^
      defaultSchedule.hashCode ^
      price.hashCode ^
      operatingLicense.hashCode ^
      status.hashCode ^
      activatedAt.hashCode ^
      activatedBy.hashCode ^
      rejectionReason.hashCode ^
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode;
}
