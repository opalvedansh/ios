import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';

part 'subscription.freezed.dart';
part 'subscription.g.dart';

/// Subscription model tracking customer's plan and billing
@freezed
class Subscription with _$Subscription {
  const factory Subscription({
    required String id, // Firestore document ID
    required String customerId, // Reference to customer
    required String planId, // Razorpay plan ID
    required String areaId, // Service area
    required String vehicleType, // 'hatchback' | 'sedan' | 'suv'

    // Razorpay data
    String? razorpaySubscriptionId, // From Razorpay webhook
    String? razorpayCustomerId, // From Razorpay

    // Status: 'active' | 'cancelled' | 'paused' | 'overdue' | 'expired'
    @Default('active') String status,

    // Billing cycle
    @TimestampConverter() required DateTime startDate,
    @TimestampConverter() required DateTime currentPeriodStart,
    @TimestampConverter() required DateTime currentPeriodEnd,
    @TimestampConverter() DateTime? cancelledAt,
    @TimestampConverter() DateTime? pausedAt,

    // Cycle stats (reset monthly)
    @Default(0) int currentCycleDays, // Days since current period start
    @Default(0) int currentCycleCleaned, // Cleanings completed this cycle
    @Default(0) int currentCycleMissed, // Cleanings missed this cycle

    // Lifetime stats (never reset)
    @Default(0) int totalCycles, // Number of billing cycles completed
    @Default(0) int totalDaysCleaned, // All-time cleanings
    @Default(0) int totalDaysMissed, // All-time missed

    // Plan change tracking
    String? previousPlanId, // For downgrades/upgrades
    @TimestampConverter() DateTime? lastPlanChangeDate,

    // Metadata
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _Subscription;

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  factory Subscription.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return Subscription.fromJson(data);
  }
}

/// Subscription history entry (for audit trail)
@freezed
class SubscriptionHistory with _$SubscriptionHistory {
  const factory SubscriptionHistory({
    required String id,
    required String subscriptionId,
    required String customerId,

    // What changed
    required String
        eventType, // 'created' | 'plan_changed' | 'cancelled' | 'renewed' | 'paused' | 'resumed'
    required Map<String, dynamic> changes, // What was updated

    // Context
    String? reason, // Why it changed (user request, payment failure, etc.)
    String? initiatedBy, // 'customer' | 'admin' | 'system'

    @TimestampConverter() required DateTime timestamp,
  }) = _SubscriptionHistory;

  factory SubscriptionHistory.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionHistoryFromJson(json);

  factory SubscriptionHistory.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    data['id'] = doc.id;
    return SubscriptionHistory.fromJson(data);
  }
}
