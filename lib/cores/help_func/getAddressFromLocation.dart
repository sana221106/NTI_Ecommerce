import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getAddressFromLocation(Position position) async {
  try {
    final Geocoding geocoding = Geocoding();

    final List<Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isEmpty) {
      return 'Unknown location';
    }

    final Placemark place = placemarks.first;

    final List<String> addressParts = [];

    if (place.street != null && place.street!.isNotEmpty) {
      addressParts.add(place.street!);
    }

    if (place.locality != null && place.locality!.isNotEmpty) {
      addressParts.add(place.locality!);
    }

    if (place.administrativeArea != null &&
        place.administrativeArea!.isNotEmpty &&
        place.administrativeArea != place.locality) {
      addressParts.add(place.administrativeArea!);
    }

    if (place.country != null && place.country!.isNotEmpty) {
      addressParts.add(place.country!);
    }

    return addressParts.join(', ');
  } catch (e) {
    return 'Unable to get address';
  }
}