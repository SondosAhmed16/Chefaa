import 'package:chefaa/core/resources/color.dart';
import 'package:chefaa/core/resources/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationFilter extends StatefulWidget {
  const LocationFilter({super.key});

  @override
  State<LocationFilter> createState() => _LocationFilterState();
}

class _LocationFilterState extends State<LocationFilter> {
  GoogleMapController? _mapController;
  BitmapDescriptor customIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  Set<Marker> markers = {};
  LatLng? _currentPosition;
  bool _isResolvingLocation = true;
  bool _canShowMyLocation = false;
  final TextEditingController _searchController = TextEditingController();
  static const LatLng _fallbackPosition = LatLng(30.0444, 31.2357);

  @override
  void dispose() {
    _searchController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _resolveCurrentLocation();
  }

  void _searchLocation(String address) async {
    try {
      setState(() => _isResolvingLocation = true);
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        LatLng newPos = LatLng(locations[0].latitude, locations[0].longitude);

        setState(() {
          _currentPosition = newPos;
          _isResolvingLocation = false;
          markers = {
            Marker(
              markerId: const MarkerId("selected"),
              position: newPos,
              icon: customIcon,
            ),
          };
        });

        await _moveCamera(newPos);
      }
    } catch (e) {
      setState(() => _isResolvingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No results found for this address")),
        );
      }
    }
  }

  Future<void> _resolveCurrentLocation() async {
    setState(() => _isResolvingLocation = true);
    final hasPermission = await _requestLocationPermission();
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!hasPermission || !serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _currentPosition ??= _fallbackPosition;
        _isResolvingLocation = false;
        _canShowMyLocation = false;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final currentLocation = LatLng(position.latitude, position.longitude);

      if (!mounted) return;
      setState(() {
        _currentPosition = currentLocation;
        _isResolvingLocation = false;
        _canShowMyLocation = true;
        markers = {
          Marker(
            markerId: const MarkerId('current-location'),
            position: currentLocation,
            icon: customIcon,
          ),
        };
      });
      await _moveCamera(currentLocation);
    } catch (_) {
      if (mounted) setState(() => _isResolvingLocation = false);
    }
  }

  Future<void> _moveCamera(LatLng position) async {
    final controller = _mapController;
    if (controller == null) return;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 15),
      ),
    );
  }

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) openAppSettings();
    return false;
  }

  void _confirmLocation() {
    final locationQuery = _searchController.text.trim();
    if (locationQuery.isNotEmpty) {
      Navigator.pop(context, locationQuery);
    } else {
      Navigator.pop(context, "Selected Area");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [
          // Google Map Background
          Positioned.fill(
            child: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              myLocationEnabled: _canShowMyLocation,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? _fallbackPosition,
                zoom: 14,
              ),
              markers: markers,
              onTap: (LatLng position) {
                setState(() {
                  _currentPosition = position;
                  markers = {
                    Marker(
                      markerId: const MarkerId("selected"),
                      position: position,
                      icon: customIcon,
                    ),
                  };
                });
              },
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorManager.white,
                    ColorManager.white.withValues(alpha: 0.92),
                    ColorManager.white.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: ColorManager.black,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Nearby",
                        style: getSemiBoldStyle(
                          fontSize: 20,
                          color: ColorManager.black,
                        ),
                      ),
                      const Spacer(),
                      48.horizontalSpace,
                    ],
                  ),
                  12.verticalSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: ColorManager.input.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withValues(alpha: 0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        final query = value.trim();
                        if (query.isNotEmpty) _searchLocation(query);
                      },
                      decoration: InputDecoration(
                        hintText: "Search by area, street, or landmark",
                        hintStyle: getRegularStyle(
                          color: ColorManager.gray,
                          fontSize: 14,
                        ),
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: ColorManager.gray,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            final query = _searchController.text.trim();
                            if (query.isEmpty) {
                              _searchController.clear();
                              return;
                            }
                            _searchLocation(query);
                          },
                          icon: const Icon(
                            Icons.north_east,
                            color: ColorManager.primary,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (_isResolvingLocation)
            const Positioned.fill(
              child: Center(child: CircularProgressIndicator()),
            ),

          Positioned(
            bottom: 180.h,
            right: 16,
            child: FloatingActionButton(
              heroTag: "my_location_btn",
              mini: true,
              backgroundColor: ColorManager.white,
              elevation: 4,
              onPressed: _resolveCurrentLocation,
              child: const Icon(Icons.my_location, color: ColorManager.primary),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: ColorManager.input,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    12.verticalSpace,
                    Text(
                      "Search Doctors in Selected Area",
                      style: getSemiBoldStyle(
                        fontSize: 16,
                        color: ColorManager.black,
                      ),
                    ),
                    16.verticalSpace,
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _confirmLocation,
                        child: Text(
                          "Confirm Location",
                          style: getSemiBoldStyle(
                            fontSize: 16,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}