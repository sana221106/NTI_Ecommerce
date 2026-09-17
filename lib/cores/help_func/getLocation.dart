import 'package:geolocator/geolocator.dart';

Future<Position> getUserLocation() async {
  // Check if Location Service is enabled
  final bool serviceEnabled =
      await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    throw Exception('Location service is disabled.');
  }

  // Check permission
  LocationPermission permission =
      await Geolocator.checkPermission();

  // Request permission if needed
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied.');
    }
  }

  // Permission permanently denied
  if (permission == LocationPermission.deniedForever) {
    throw Exception(
      'Location permission permanently denied.',
    );
  }

  // Get current location
  return await Geolocator.getCurrentPosition();
}