import 'dart:convert';

class OrderRequestModel {
  String? pharmacyId;
  String? orderType;
  String? paymentMethod;
  List<OrderItemModel>? items;
  DeliveryAddressDetails? deliveryAddressDetails;

  OrderRequestModel({
    this.pharmacyId,
    this.orderType,
    this.paymentMethod,
    this.items,
    this.deliveryAddressDetails,
  });

  factory OrderRequestModel.fromMap(Map<String, dynamic> data) {
    return OrderRequestModel(
      pharmacyId: data['pharmacyId'] as String?,
      orderType: data['orderType'] as String?,
      paymentMethod: data['paymentMethod'] as String?,
      items: (data['items'] as List<dynamic>?)
          ?.map((e) => OrderItemModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      deliveryAddressDetails: data['deliveryAddressDetails'] == null
          ? null
          : DeliveryAddressDetails.fromMap(
              data['deliveryAddressDetails'] as Map<String, dynamic>,
            ),
    );
  }

  Map<String, dynamic> toMap() => {
    'pharmacyId': pharmacyId,
    'orderType': orderType,
    'paymentMethod': paymentMethod,
    'items': items?.map((e) => e.toMap()).toList(),
    'deliveryAddressDetails': deliveryAddressDetails?.toMap(),
  };

  factory OrderRequestModel.fromJson(String data) {
    return OrderRequestModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

class OrderItemModel {
  String? medicineId;
  String? medicineName;
  int? quantity;

  OrderItemModel({this.medicineId, this.medicineName, this.quantity});

  factory OrderItemModel.fromMap(Map<String, dynamic> data) => OrderItemModel(
    medicineId: data['medicineId'] as String?,
    medicineName: data['medicineName'] as String?,
    quantity: data['quantity'] as int?,
  );

  Map<String, dynamic> toMap() => {
    'medicineId': medicineId,
    'medicineName': medicineName,
    'quantity': quantity,
  };

  factory OrderItemModel.fromJson(String data) {
    return OrderItemModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

class DeliveryAddressDetails {
  String? fullName;
  String? phoneNumber;
  String? cityDistrict;
  String? streetAddress;
  OrderLocation? location;

  DeliveryAddressDetails({
    this.fullName,
    this.phoneNumber,
    this.cityDistrict,
    this.streetAddress,
    this.location,
  });

  factory DeliveryAddressDetails.fromMap(Map<String, dynamic> data) {
    return DeliveryAddressDetails(
      fullName: data['fullName'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      cityDistrict: data['cityDistrict'] as String?,
      streetAddress: data['streetAddress'] as String?,
      location: data['location'] == null
          ? null
          : OrderLocation.fromMap(data['location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'cityDistrict': cityDistrict,
    'streetAddress': streetAddress,
    'location': location?.toMap(),
  };

  factory DeliveryAddressDetails.fromJson(String data) {
    return DeliveryAddressDetails.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  String toJson() => json.encode(toMap());
}

class OrderLocation {
  String? type;
  List<double>? coordinates;

  OrderLocation({this.type, this.coordinates});

  factory OrderLocation.fromMap(Map<String, dynamic> data) => OrderLocation(
    type: data['type'] as String?,
    coordinates: (data['coordinates'] as List<dynamic>?)
        ?.map((e) => (e as num).toDouble())
        .toList(),
  );

  Map<String, dynamic> toMap() => {'type': type, 'coordinates': coordinates};

  factory OrderLocation.fromJson(String data) {
    return OrderLocation.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}
