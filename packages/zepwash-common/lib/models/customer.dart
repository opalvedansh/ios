import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const factory Customer({
    required String id, // Auto-generated Firestore doc ID
    required String userId, // Firebase Auth UID of the owning user
    String? label, // Optional display name, e.g. "White Honda City"
    @Default('') String address, // Full address as string
    @GeoPointConverter()
    @Default(GeoPoint(0, 0))
    GeoPoint geopoint, // For location-based features
    @Default('sedan') String vehicleType, // 'hatchback' | 'sedan' | 'suv'
    @Default('') String plateCode, // Last 6 digits
    @Default('') String vehicleModel,
    String? assignedStaffId,

    // Subscription reference (for quick access)
    String? activeSubscriptionId, // Current subscription ID
    @Default('inactive')
    String subscriptionStatus, // 'active' | 'inactive' | 'cancelled' | 'paused'

    // Denormalized for quick display (synced from Subscription)
    String? currentPlanId,
    String? currentAreaId,
    @TimestampConverter()
    DateTime? currentPeriodEnd, // For "X days remaining" display

    @TimestampConverter() DateTime? createdAt,
  }) = _Customer;

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  factory Customer.fromFirestore(DocumentSnapshot doc) {
    final data = (doc.data() as Map<String, dynamic>?) ?? {};
    data['id'] = doc.id;
    return Customer.fromJson(data);
  }
}
