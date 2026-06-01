import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'dart:async';
import '../utils/exceptions.dart';

class LocationService {
  // Get current position
  Future<Position> getCurrentPosition() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationException(
        'Location services are disabled. Please enable them and try again.',
      );
    }

    // Check permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationException('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationException(
        'Location permissions are permanently denied. '
        'Please enable them from settings.',
      );
    }

    try {
      // Increase timeout to 30 seconds for better reliability
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        timeLimit: const Duration(seconds: 30),
      ).timeout(const Duration(seconds: 30));
    } on TimeoutException {
      // Try to get last known position as a fallback if current position times out
      final lastKnown = await Geolocator.getLastKnownPosition();
      if (lastKnown != null) {
        return lastKnown;
      }
      throw LocationException(
        'The location request timed out. Please ensure you are in an open area and try again.',
      );
    } catch (e) {
      if (e is TimeoutException) {
        // Handle case where geolocator internal timeout doesn't catch it correctly
        final lastKnown = await Geolocator.getLastKnownPosition();
        if (lastKnown != null) {
          return lastKnown;
        }
        throw LocationException(
          'The location request timed out. Please ensure you are in an open area and try again.',
        );
      }
      throw LocationException('Failed to get location: $e');
    }
  }

  // Haversine distance calculation (returns meters)
  double calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const R = 6371000; // Earth's radius in meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in meters
  }

  double _toRadians(double degree) => degree * pi / 180;

  // Check if point is within radius
  bool isWithinRadius(
    double pointLat,
    double pointLon,
    double centerLat,
    double centerLon,
    double radiusMeters,
  ) {
    final distance =
        calculateDistance(pointLat, pointLon, centerLat, centerLon);
    return distance <= radiusMeters;
  }
}
