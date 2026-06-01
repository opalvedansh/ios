import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zepwash_common/zepwash_common.dart';
import '../../../core/providers/auth_provider.dart';
import '../../../core/providers/firestore_provider.dart';

/// Streams all vehicle profiles owned by the current user
final customerProfilesProvider = StreamProvider<List<Customer>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) return Stream.value([]);

  return FirebaseFirestore.instance
      .collection('customers')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snap) => snap.docs.map(Customer.fromFirestore).toList());
});

/// The currently selected vehicle profile's doc ID (persisted in state)
final selectedCustomerIdProvider = StateProvider<String?>((ref) => null);

/// The currently active customer profile (falls back to first if none selected)
final selectedCustomerProvider = Provider<Customer?>((ref) {
  final profiles = ref.watch(customerProfilesProvider).value ?? [];
  if (profiles.isEmpty) return null;
  final selectedId = ref.watch(selectedCustomerIdProvider);
  if (selectedId != null) {
    return profiles.firstWhereOrNull((c) => c.id == selectedId) ?? profiles.first;
  }
  return profiles.first;
});

/// Backward-compatible alias — returns the selected customer (nullable)
final customerDataProvider = Provider<Customer?>((ref) {
  return ref.watch(selectedCustomerProvider);
});

/// Provider to fetch current user data (name, phone)
final userDataProvider = StreamProvider<User?>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null) {
    return Stream.value(null);
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((doc) {
    if (!doc.exists) return null;
    return User.fromFirestore(doc);
  });
});

/// Provider to fetch assigned staff for the selected customer
final assignedStaffProvider = FutureProvider<Staff?>((ref) async {
  final staffId = ref.watch(
    selectedCustomerProvider.select((v) => v?.assignedStaffId),
  );
  if (staffId == null) return null;

  final firestoreService = ref.read(firestoreServiceProvider);
  final staffDoc = await firestoreService.getDocument('staff', staffId);

  if (!staffDoc.exists) return null;
  return Staff.fromFirestore(staffDoc);
});

/// Provider to fetch the selected customer's area information
final customerAreaProvider = FutureProvider<Area?>((ref) async {
  final areaId = ref.watch(
    selectedCustomerProvider.select((v) => v?.currentAreaId),
  );
  if (areaId == null) return null;

  final firestoreService = ref.read(firestoreServiceProvider);
  final areaDoc = await firestoreService.getDocument('areas', areaId);

  if (!areaDoc.exists) return null;
  return Area.fromFirestore(areaDoc);
});

/// Provider to check if the selected customer has an active subscription
final hasActiveSubscriptionProvider = Provider<bool>((ref) {
  final customer = ref.watch(selectedCustomerProvider);
  return customer?.subscriptionStatus == 'active';
});

/// Lightweight data class for supervisor display
class SupervisorInfo {
  final String name;
  final String phone;
  final String? email;
  const SupervisorInfo({required this.name, required this.phone, this.email});
}

/// Provider to fetch the supervisor for the selected customer's area
final areaSupervisorProvider = FutureProvider<SupervisorInfo?>((ref) async {
  final supervisorIds = ref.watch(
    customerAreaProvider.select((v) => v.value?.supervisorIds),
  );
  if (supervisorIds == null || supervisorIds.isEmpty) return null;

  final supervisorId = supervisorIds.first;
  final doc = await FirebaseFirestore.instance
      .collection('supervisors')
      .doc(supervisorId)
      .get();

  if (!doc.exists) return null;
  final data = doc.data()!;
  return SupervisorInfo(
    name: data['name'] as String? ?? 'Supervisor',
    phone: data['phone'] as String? ?? '',
    email: data['email'] as String?,
  );
});
