class AddressEntity {
  final String addressText;
  final double longitude;
  final double latitude;

  AddressEntity({
    required this.addressText,
    required this.longitude,
    required this.latitude,
  });

  Map<String, dynamic> toJson() => {
    "address": {
      "addressText": addressText,
      "location": {
        "type": "point",
        "coordinates": [longitude, latitude],
      },
    },
  };
}
