import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:zepwash_common/zepwash_common.dart';
import 'auth_provider.dart';
import 'firestore_provider.dart';

/// Provider to get current GPS position (cached for session)
final currentPositionProvider = FutureProvider<Position?>((ref) async {
  // Watch auth state to re-trigger location request after login
  ref.watch(currentUserIdProvider);
  
  final locationService = LocationService();
  try {
    return await locationService.getCurrentPosition();
  } on LocationException {
    return null;
  }
});

/// Provider to fetch all active areas
final allAreasProvider = FutureProvider<List<Area>>((ref) async {
  final firestoreService = ref.read(firestoreServiceProvider);
  final areasSnapshot = await firestoreService.getCollection('areas');

  return areasSnapshot.docs
      .where((doc) => doc.exists)
      .map((doc) => Area.fromFirestore(doc))
      .where((area) => area.isActive)
      .toList();
});

/// Holds an Area with its computed straight-line distance from the user (meters).
class AreaWithDistance {
  final Area area;
  final double? distanceMeters; // null if location unavailable
  AreaWithDistance(this.area, this.distanceMeters);
}

/// All active areas sorted by distance from user (closest first).
/// Falls back to alphabetical if location is unavailable.
final sortedAreasByDistanceProvider =
    FutureProvider<List<AreaWithDistance>>((ref) async {
  final allAreas = await ref.watch(allAreasProvider.future);
  final position = await ref.watch(currentPositionProvider.future);
  final locationService = LocationService();

  final withDistance = allAreas.map((area) {
    if (position == null) return AreaWithDistance(area, null);
    final meters = locationService.calculateDistance(
      position.latitude,
      position.longitude,
      area.center.latitude,
      area.center.longitude,
    );
    return AreaWithDistance(area, meters);
  }).toList();

  if (position != null) {
    withDistance.sort(
        (a, b) => (a.distanceMeters ?? 0).compareTo(b.distanceMeters ?? 0));
  } else {
    withDistance.sort((a, b) => a.area.name.compareTo(b.area.name));
  }

  return withDistance;
});
