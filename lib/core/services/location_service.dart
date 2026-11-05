import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationDataModel {
  final double lat;
  final double lng;
  final String? addressText;

  LocationDataModel({required this.lat, required this.lng, this.addressText});
}

class LocationService {
  static Future<LocationDataModel?> getLocationWithAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      String? address;

      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          address =
              "${place.locality ?? ''}, ${place.subAdministrativeArea ?? ''}, ${place.country ?? ''}";
        }
      } catch (e) {
        address = null;
      }

      return LocationDataModel(
        lat: position.latitude,
        lng: position.longitude,
        addressText: address,
      );
    } catch (e) {
      return null;
    }
  }
}
