import 'dart:convert';

import 'package:collection/collection.dart';

import 'address.dart';
import 'city_delivery_price.dart';
import 'delivery_pricing.dart';
import 'settings.dart';
import 'stats.dart';
import 'working_hour.dart';

class Data {
  String? pharmacyName;
  String? commercialRegisterNumber;
  String? licenseExpiry;
  double? rating;
  String? about;
  bool? openNow;
  bool? deliveryAvailable;
  String? visibilityStatus;
  Stats? stats;
  String? phone;
  List<WorkingHour>? workingHours;
  List<Address>? addresses;
  List<String>? deliveryArea;
  List<CityDeliveryPrice>? cityDeliveryPrices;
  List<DeliveryPricing>? deliveryPricing;
  List<String>? paymentMethods;
  String? deliveryTime;
  int? deliveryFee;
  int? minimumOrder;
  Settings? settings;

  Data({
    this.pharmacyName,
    this.commercialRegisterNumber,
    this.licenseExpiry,
    this.rating,
    this.about,
    this.openNow,
    this.deliveryAvailable,
    this.visibilityStatus,
    this.stats,
    this.phone,
    this.workingHours,
    this.addresses,
    this.deliveryArea,
    this.cityDeliveryPrices,
    this.deliveryPricing,
    this.paymentMethods,
    this.deliveryTime,
    this.deliveryFee,
    this.minimumOrder,
    this.settings,
  });

  @override
  String toString() {
    return 'Data(pharmacyName: $pharmacyName, commercialRegisterNumber: $commercialRegisterNumber, licenseExpiry: $licenseExpiry, rating: $rating, about: $about, openNow: $openNow, deliveryAvailable: $deliveryAvailable, visibilityStatus: $visibilityStatus, stats: $stats, phone: $phone, workingHours: $workingHours, addresses: $addresses, deliveryArea: $deliveryArea, cityDeliveryPrices: $cityDeliveryPrices, deliveryPricing: $deliveryPricing, paymentMethods: $paymentMethods, deliveryTime: $deliveryTime, deliveryFee: $deliveryFee, minimumOrder: $minimumOrder, settings: $settings)';
  }

  factory Data.fromMap(Map<String, dynamic> data) => Data(
    pharmacyName: data['pharmacyName'] as String?,
    commercialRegisterNumber: data['commercialRegisterNumber'] as String?,
    licenseExpiry: data['licenseExpiry'] as String?,
    rating: (data['rating'] as num?)?.toDouble(),
    about: data['about'] as String?,
    openNow: data['openNow'] as bool?,
    deliveryAvailable: data['deliveryAvailable'] as bool?,
    visibilityStatus: data['visibilityStatus'] as String?,
    stats: data['stats'] == null
        ? null
        : Stats.fromMap(data['stats'] as Map<String, dynamic>),
    phone: data['phone'] as String?,
    workingHours: (data['workingHours'] as List<dynamic>?)
        ?.map((e) => WorkingHour.fromMap(e as Map<String, dynamic>))
        .toList(),
    addresses: (data['addresses'] as List<dynamic>?)
        ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
        .toList(),
    deliveryArea: data['deliveryArea'] == null
        ? null
        : (data['deliveryArea'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),

    paymentMethods: data['paymentMethods'] == null
        ? null
        : (data['paymentMethods'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
    cityDeliveryPrices: (data['cityDeliveryPrices'] as List<dynamic>?)
        ?.map((e) => CityDeliveryPrice.fromMap(e as Map<String, dynamic>))
        .toList(),
    deliveryPricing: (data['deliveryPricing'] as List<dynamic>?)
        ?.map((e) => DeliveryPricing.fromMap(e as Map<String, dynamic>))
        .toList(),

    deliveryTime: data['deliveryTime'] as String?,
    deliveryFee: data['deliveryFee'] as int?,
    minimumOrder: data['minimumOrder'] as int?,
    settings: data['settings'] == null
        ? null
        : Settings.fromMap(data['settings'] as Map<String, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'pharmacyName': pharmacyName,
    'commercialRegisterNumber': commercialRegisterNumber,
    'licenseExpiry': licenseExpiry,
    'rating': rating,
    'about': about,
    'openNow': openNow,
    'deliveryAvailable': deliveryAvailable,
    'visibilityStatus': visibilityStatus,
    'stats': stats?.toMap(),
    'phone': phone,
    'workingHours': workingHours?.map((e) => e.toMap()).toList(),
    'addresses': addresses?.map((e) => e.toMap()).toList(),
    'deliveryArea': deliveryArea,
    'cityDeliveryPrices': cityDeliveryPrices?.map((e) => e.toMap()).toList(),
    'deliveryPricing': deliveryPricing?.map((e) => e.toMap()).toList(),
    'paymentMethods': paymentMethods,
    'deliveryTime': deliveryTime,
    'deliveryFee': deliveryFee,
    'minimumOrder': minimumOrder,
    'settings': settings?.toMap(),
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
    String? commercialRegisterNumber,
    String? licenseExpiry,
    double? rating,
    String? about,
    bool? openNow,
    bool? deliveryAvailable,
    String? visibilityStatus,
    Stats? stats,
    String? phone,
    List<WorkingHour>? workingHours,
    List<Address>? addresses,
    List<String>? deliveryArea,
    List<CityDeliveryPrice>? cityDeliveryPrices,
    List<DeliveryPricing>? deliveryPricing,
    List<String>? paymentMethods,
    String? deliveryTime,
    int? deliveryFee,
    int? minimumOrder,
    Settings? settings,
  }) {
    return Data(
      pharmacyName: pharmacyName ?? this.pharmacyName,
      commercialRegisterNumber:
          commercialRegisterNumber ?? this.commercialRegisterNumber,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      rating: rating ?? this.rating,
      about: about ?? this.about,
      openNow: openNow ?? this.openNow,
      deliveryAvailable: deliveryAvailable ?? this.deliveryAvailable,
      visibilityStatus: visibilityStatus ?? this.visibilityStatus,
      stats: stats ?? this.stats,
      phone: phone ?? this.phone,
      workingHours: workingHours ?? this.workingHours,
      addresses: addresses ?? this.addresses,
      deliveryArea: deliveryArea ?? this.deliveryArea,
      cityDeliveryPrices: cityDeliveryPrices ?? this.cityDeliveryPrices,
      deliveryPricing: deliveryPricing ?? this.deliveryPricing,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      settings: settings ?? this.settings,
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
      commercialRegisterNumber.hashCode ^
      licenseExpiry.hashCode ^
      rating.hashCode ^
      about.hashCode ^
      openNow.hashCode ^
      deliveryAvailable.hashCode ^
      visibilityStatus.hashCode ^
      stats.hashCode ^
      phone.hashCode ^
      workingHours.hashCode ^
      addresses.hashCode ^
      deliveryArea.hashCode ^
      cityDeliveryPrices.hashCode ^
      deliveryPricing.hashCode ^
      paymentMethods.hashCode ^
      deliveryTime.hashCode ^
      deliveryFee.hashCode ^
      minimumOrder.hashCode ^
      settings.hashCode;
}
