import 'dart:convert';

import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model/city_delivery_price..dart';
import 'package:chefaa/features/patient/pharmacy%20search/data/model/pharmacy_profile_model/working_hour..dart';
import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/address.dart';
import 'package:chefaa/features/pharmacy/profile/data/model/get_pharmacy_profile/location.dart';
import 'package:collection/collection.dart';

import 'delivery_pricing.dart';
import 'financials.dart';

class Data {
  String? pharmacyName;
  Financials? financials;
  Location? location;
  String? id;
  String? userId;
  String? commercialRegisterNumber;
  String? medicalLicencePdf;
  double? rating;
  int? totalReviews;
  bool? alwaysOpen;
  bool? openNow;
  bool? deliveryAvailable;
  bool? prescriptionOnly;
  String? visibilityStatus;
  dynamic hiddenAt;
  dynamic hiddenReason;
  int? commissionRate;
  String? deliveryTime;
  int? deliveryFee;
  int? minimumOrder;
  List<String>? deliveryArea;
  List<dynamic>? services;
  List<String>? paymentMethods;
  String? licenseExpiry;
  List<Address>? addresses;
  List<CityDeliveryPrice>? cityDeliveryPrices;
  List<WorkingHour>? workingHours;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? phone;
  String? about;
  List<DeliveryPricing>? deliveryPricing;

  Data({
    this.pharmacyName,
    this.financials,
    this.location,
    this.id,
    this.userId,
    this.commercialRegisterNumber,
    this.medicalLicencePdf,
    this.rating,
    this.totalReviews,
    this.alwaysOpen,
    this.openNow,
    this.deliveryAvailable,
    this.prescriptionOnly,
    this.visibilityStatus,
    this.hiddenAt,
    this.hiddenReason,
    this.commissionRate,
    this.deliveryTime,
    this.deliveryFee,
    this.minimumOrder,
    this.deliveryArea,
    this.services,
    this.paymentMethods,
    this.licenseExpiry,
    this.addresses,
    this.cityDeliveryPrices,
    this.workingHours,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.phone,
    this.about,
    this.deliveryPricing,
  });

  @override
  String toString() {
    return 'Data(pharmacyName: $pharmacyName, financials: $financials, location: $location, id: $id, userId: $userId, commercialRegisterNumber: $commercialRegisterNumber, medicalLicencePdf: $medicalLicencePdf, rating: $rating, totalReviews: $totalReviews, alwaysOpen: $alwaysOpen, openNow: $openNow, deliveryAvailable: $deliveryAvailable, prescriptionOnly: $prescriptionOnly, visibilityStatus: $visibilityStatus, hiddenAt: $hiddenAt, hiddenReason: $hiddenReason, commissionRate: $commissionRate, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, minimumOrder: $minimumOrder, deliveryArea: $deliveryArea, services: $services, paymentMethods: $paymentMethods, licenseExpiry: $licenseExpiry, addresses: $addresses, cityDeliveryPrices: $cityDeliveryPrices, workingHours: $workingHours, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, phone: $phone, about: $about, deliveryPricing: $deliveryPricing)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    pharmacyName: data['pharmacyName'] as String?,
    financials: data['financials'] == null
        ? null
        : Financials.fromMap(data['financials'] as Map<String, dynamic>),
    location: data['location'] == null
        ? null
        : Location.fromMap(data['location'] as Map<String, dynamic>),
    id: data['_id'] as String?,
    userId: data['userId'] as String?,
    commercialRegisterNumber: data['commercialRegisterNumber'] as String?,
    medicalLicencePdf: data['medicalLicencePdf'] as String?,
    rating: (data['rating'] as num?)?.toDouble(),
    totalReviews: data['totalReviews'] as int?,
    alwaysOpen: data['alwaysOpen'] as bool?,
    openNow: data['openNow'] as bool?,
    deliveryAvailable: data['deliveryAvailable'] as bool?,
    prescriptionOnly: data['prescriptionOnly'] as bool?,
    visibilityStatus: data['visibilityStatus'] as String?,
    hiddenAt: data['hiddenAt'] as dynamic,
    hiddenReason: data['hiddenReason'] as dynamic,
    commissionRate: data['commissionRate'] as int?,
    deliveryTime: data['deliveryTime'] as String?,
    deliveryFee: data['deliveryFee'] as int?,
    minimumOrder: data['minimumOrder'] as int?,
    paymentMethods: data['paymentMethods'] == null
        ? null
        : (data['paymentMethods'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),

    deliveryArea: data['deliveryArea'] == null
        ? null
        : (data['deliveryArea'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
    services: data['services'] as List<dynamic>?,
    licenseExpiry: data['licenseExpiry'] as String?,
    addresses: (data['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
        .toList(),
    cityDeliveryPrices: (data['cityDeliveryPrices'] as List<dynamic>?)
        ?.map((e) => CityDeliveryPrice.fromMap(e as Map<String, dynamic>))
        .toList(),
    workingHours: (data['workingHours'] as List<dynamic>?)
        ?.map((e) => WorkingHour.fromMap(e as Map<String, dynamic>))
        .toList(),
    createdAt: data['createdAt'] == null
        ? null
        : DateTime.parse(data['createdAt'] as String),
    updatedAt: data['updatedAt'] == null
        ? null
        : DateTime.parse(data['updatedAt'] as String),
    v: data['__v'] as int?,
    phone: data['phone'] as String?,
    about: data['about'] as String?,
    deliveryPricing: (data['deliveryPricing'] as List<dynamic>?)
        ?.map((e) => DeliveryPricing.fromMap(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toMap() => {
    'pharmacyName': pharmacyName,
    'financials': financials?.toMap(),
    'location': location?.toMap(),
    '_id': id,
    'userId': userId,
    'commercialRegisterNumber': commercialRegisterNumber,
    'medicalLicencePdf': medicalLicencePdf,
    'rating': rating,
    'totalReviews': totalReviews,
    'alwaysOpen': alwaysOpen,
    'openNow': openNow,
    'deliveryAvailable': deliveryAvailable,
    'prescriptionOnly': prescriptionOnly,
    'visibilityStatus': visibilityStatus,
    'hiddenAt': hiddenAt,
    'hiddenReason': hiddenReason,
    'commissionRate': commissionRate,
    'deliveryTime': deliveryTime,
    'deliveryFee': deliveryFee,
    'minimumOrder': minimumOrder,
    'deliveryArea': deliveryArea,
    'services': services,
    'paymentMethods': paymentMethods,
    'licenseExpiry': licenseExpiry,
    'addresses': addresses?.map((e) => e.toMap()).toList(),
    'cityDeliveryPrices': cityDeliveryPrices?.map((e) => e.toMap()).toList(),
    'workingHours': workingHours?.map((e) => e.toMap()).toList(),
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
    '__v': v,
    'phone': phone,
    'about': about,
    'deliveryPricing': deliveryPricing?.map((e) => e.toMap()).toList(),
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
    String? pharmacyName,
    Financials? financials,
    Location? location,
    String? id,
    String? userId,
    String? commercialRegisterNumber,
    String? medicalLicencePdf,
    double? rating,
    int? totalReviews,
    bool? alwaysOpen,
    bool? openNow,
    bool? deliveryAvailable,
    bool? prescriptionOnly,
    String? visibilityStatus,
    dynamic hiddenAt,
    dynamic hiddenReason,
    int? commissionRate,
    String? deliveryTime,
    int? deliveryFee,
    int? minimumOrder,
    List<String>? deliveryArea,
    List<dynamic>? services,
    List<String>? paymentMethods,
    String? licenseExpiry,
    List<Address>? addresses,
    List<CityDeliveryPrice>? cityDeliveryPrices,
    List<WorkingHour>? workingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    String? phone,
    String? about,
    List<DeliveryPricing>? deliveryPricing,
  }) {
    return Data(
      pharmacyName: pharmacyName ?? this.pharmacyName,
      financials: financials ?? this.financials,
      location: location ?? this.location,
      id: id ?? this.id,
      userId: userId ?? this.userId,
      commercialRegisterNumber:
          commercialRegisterNumber ?? this.commercialRegisterNumber,
      medicalLicencePdf: medicalLicencePdf ?? this.medicalLicencePdf,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      alwaysOpen: alwaysOpen ?? this.alwaysOpen,
      openNow: openNow ?? this.openNow,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
      prescriptionOnly: prescriptionOnly ?? this.prescriptionOnly,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      hiddenAt: hiddenAt ?? this.hiddenAt,
      hiddenReason: hiddenReason ?? this.hiddenReason,
      commissionRate: commissionRate ?? this.commissionRate,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      deliveryArea: deliveryArea ?? this.deliveryArea,
      services: services ?? this.services,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      addresses: addresses ?? this.addresses,
      cityDeliveryPrices: cityDeliveryPrices ?? this.cityDeliveryPrices,
      workingHours: workingHours ?? this.workingHours,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      phone: phone ?? this.phone,
      about: about ?? this.about,
      deliveryPricing: deliveryPricing ?? this.deliveryPricing,
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
      pharmacyName.hashCode ^
      financials.hashCode ^
      location.hashCode ^
      id.hashCode ^
      userId.hashCode ^
      commercialRegisterNumber.hashCode ^
      medicalLicencePdf.hashCode ^
      rating.hashCode ^
      totalReviews.hashCode ^
      alwaysOpen.hashCode ^
      openNow.hashCode ^
      deliveryAvailable.hashCode ^
      prescriptionOnly.hashCode ^
      visibilityStatus.hashCode ^
      hiddenAt.hashCode ^
      hiddenReason.hashCode ^
      commissionRate.hashCode ^
      deliveryTime.hashCode ^
      deliveryFee.hashCode ^
      minimumOrder.hashCode ^
      deliveryArea.hashCode ^
      services.hashCode ^
      paymentMethods.hashCode ^
      licenseExpiry.hashCode ^
      addresses.hashCode ^
      cityDeliveryPrices.hashCode ^
      workingHours.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      v.hashCode ^
      phone.hashCode ^
      about.hashCode ^
      deliveryPricing.hashCode;
}
