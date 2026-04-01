import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum AppLocationStatus { disabled, denied, deniedForever, allowed }

class AppLocation {
  Future<AppLocationStatus> checkStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.checkPermission();
    return permission.toApp();
  }

  Future<AppLocationStatus> requestPermission() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.requestPermission();
    return permission.toApp();
  }

  Future<Location> getLocation() async {
    final position = await Geolocator.getCurrentPosition();
    return Location.fromPosition(position);
  }

  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
}

extension LocationPermissionX on LocationPermission {
  AppLocationStatus toApp() {
    switch (this) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return AppLocationStatus.allowed;
      case LocationPermission.denied:
        return AppLocationStatus.denied;
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        return AppLocationStatus.deniedForever;
    }
  }
}

class Location {
  Location({required this.latitude, required this.longitude});

  Location.fromPosition(Position position) : latitude = position.latitude, longitude = position.longitude;

  final double latitude;
  final double longitude;

  LatLng toLatLng() => LatLng(latitude, longitude);

  @override
  String toString() {
    return '$latitude;$longitude';
  }
}
