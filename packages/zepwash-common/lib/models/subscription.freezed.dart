// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) {
  return _Subscription.fromJson(json);
}

/// @nodoc
mixin _$Subscription {
  String get id => throw _privateConstructorUsedError; // Firestore document ID
  String get customerId =>
      throw _privateConstructorUsedError; // Reference to customer
  String get planId => throw _privateConstructorUsedError; // Razorpay plan ID
  String get areaId => throw _privateConstructorUsedError; // Service area
  String get vehicleType =>
      throw _privateConstructorUsedError; // 'hatchback' | 'sedan' | 'suv'
// Razorpay data
  String? get razorpaySubscriptionId =>
      throw _privateConstructorUsedError; // From Razorpay webhook
  String? get razorpayCustomerId =>
      throw _privateConstructorUsedError; // From Razorpay
// Status: 'active' | 'cancelled' | 'paused' | 'overdue' | 'expired'
  String get status => throw _privateConstructorUsedError; // Billing cycle
  @TimestampConverter()
  DateTime get startDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get currentPeriodStart => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get currentPeriodEnd => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get pausedAt =>
      throw _privateConstructorUsedError; // Cycle stats (reset monthly)
  int get currentCycleDays =>
      throw _privateConstructorUsedError; // Days since current period start
  int get currentCycleCleaned =>
      throw _privateConstructorUsedError; // Cleanings completed this cycle
  int get currentCycleMissed =>
      throw _privateConstructorUsedError; // Cleanings missed this cycle
// Lifetime stats (never reset)
  int get totalCycles =>
      throw _privateConstructorUsedError; // Number of billing cycles completed
  int get totalDaysCleaned =>
      throw _privateConstructorUsedError; // All-time cleanings
  int get totalDaysMissed =>
      throw _privateConstructorUsedError; // All-time missed
// Plan change tracking
  String? get previousPlanId =>
      throw _privateConstructorUsedError; // For downgrades/upgrades
  @TimestampConverter()
  DateTime? get lastPlanChangeDate =>
      throw _privateConstructorUsedError; // Metadata
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Subscription to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionCopyWith<Subscription> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionCopyWith<$Res> {
  factory $SubscriptionCopyWith(
          Subscription value, $Res Function(Subscription) then) =
      _$SubscriptionCopyWithImpl<$Res, Subscription>;
  @useResult
  $Res call(
      {String id,
      String customerId,
      String planId,
      String areaId,
      String vehicleType,
      String? razorpaySubscriptionId,
      String? razorpayCustomerId,
      String status,
      @TimestampConverter() DateTime startDate,
      @TimestampConverter() DateTime currentPeriodStart,
      @TimestampConverter() DateTime currentPeriodEnd,
      @TimestampConverter() DateTime? cancelledAt,
      @TimestampConverter() DateTime? pausedAt,
      int currentCycleDays,
      int currentCycleCleaned,
      int currentCycleMissed,
      int totalCycles,
      int totalDaysCleaned,
      int totalDaysMissed,
      String? previousPlanId,
      @TimestampConverter() DateTime? lastPlanChangeDate,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$SubscriptionCopyWithImpl<$Res, $Val extends Subscription>
    implements $SubscriptionCopyWith<$Res> {
  _$SubscriptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? planId = null,
    Object? areaId = null,
    Object? vehicleType = null,
    Object? razorpaySubscriptionId = freezed,
    Object? razorpayCustomerId = freezed,
    Object? status = null,
    Object? startDate = null,
    Object? currentPeriodStart = null,
    Object? currentPeriodEnd = null,
    Object? cancelledAt = freezed,
    Object? pausedAt = freezed,
    Object? currentCycleDays = null,
    Object? currentCycleCleaned = null,
    Object? currentCycleMissed = null,
    Object? totalCycles = null,
    Object? totalDaysCleaned = null,
    Object? totalDaysMissed = null,
    Object? previousPlanId = freezed,
    Object? lastPlanChangeDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      areaId: null == areaId
          ? _value.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      razorpaySubscriptionId: freezed == razorpaySubscriptionId
          ? _value.razorpaySubscriptionId
          : razorpaySubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayCustomerId: freezed == razorpayCustomerId
          ? _value.razorpayCustomerId
          : razorpayCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentPeriodStart: null == currentPeriodStart
          ? _value.currentPeriodStart
          : currentPeriodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentPeriodEnd: null == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _value.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentCycleDays: null == currentCycleDays
          ? _value.currentCycleDays
          : currentCycleDays // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleCleaned: null == currentCycleCleaned
          ? _value.currentCycleCleaned
          : currentCycleCleaned // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleMissed: null == currentCycleMissed
          ? _value.currentCycleMissed
          : currentCycleMissed // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysCleaned: null == totalDaysCleaned
          ? _value.totalDaysCleaned
          : totalDaysCleaned // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysMissed: null == totalDaysMissed
          ? _value.totalDaysMissed
          : totalDaysMissed // ignore: cast_nullable_to_non_nullable
              as int,
      previousPlanId: freezed == previousPlanId
          ? _value.previousPlanId
          : previousPlanId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPlanChangeDate: freezed == lastPlanChangeDate
          ? _value.lastPlanChangeDate
          : lastPlanChangeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionImplCopyWith<$Res>
    implements $SubscriptionCopyWith<$Res> {
  factory _$$SubscriptionImplCopyWith(
          _$SubscriptionImpl value, $Res Function(_$SubscriptionImpl) then) =
      __$$SubscriptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String customerId,
      String planId,
      String areaId,
      String vehicleType,
      String? razorpaySubscriptionId,
      String? razorpayCustomerId,
      String status,
      @TimestampConverter() DateTime startDate,
      @TimestampConverter() DateTime currentPeriodStart,
      @TimestampConverter() DateTime currentPeriodEnd,
      @TimestampConverter() DateTime? cancelledAt,
      @TimestampConverter() DateTime? pausedAt,
      int currentCycleDays,
      int currentCycleCleaned,
      int currentCycleMissed,
      int totalCycles,
      int totalDaysCleaned,
      int totalDaysMissed,
      String? previousPlanId,
      @TimestampConverter() DateTime? lastPlanChangeDate,
      @TimestampConverter() DateTime createdAt,
      @TimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$$SubscriptionImplCopyWithImpl<$Res>
    extends _$SubscriptionCopyWithImpl<$Res, _$SubscriptionImpl>
    implements _$$SubscriptionImplCopyWith<$Res> {
  __$$SubscriptionImplCopyWithImpl(
      _$SubscriptionImpl _value, $Res Function(_$SubscriptionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = null,
    Object? planId = null,
    Object? areaId = null,
    Object? vehicleType = null,
    Object? razorpaySubscriptionId = freezed,
    Object? razorpayCustomerId = freezed,
    Object? status = null,
    Object? startDate = null,
    Object? currentPeriodStart = null,
    Object? currentPeriodEnd = null,
    Object? cancelledAt = freezed,
    Object? pausedAt = freezed,
    Object? currentCycleDays = null,
    Object? currentCycleCleaned = null,
    Object? currentCycleMissed = null,
    Object? totalCycles = null,
    Object? totalDaysCleaned = null,
    Object? totalDaysMissed = null,
    Object? previousPlanId = freezed,
    Object? lastPlanChangeDate = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$SubscriptionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      planId: null == planId
          ? _value.planId
          : planId // ignore: cast_nullable_to_non_nullable
              as String,
      areaId: null == areaId
          ? _value.areaId
          : areaId // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      razorpaySubscriptionId: freezed == razorpaySubscriptionId
          ? _value.razorpaySubscriptionId
          : razorpaySubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      razorpayCustomerId: freezed == razorpayCustomerId
          ? _value.razorpayCustomerId
          : razorpayCustomerId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentPeriodStart: null == currentPeriodStart
          ? _value.currentPeriodStart
          : currentPeriodStart // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentPeriodEnd: null == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      pausedAt: freezed == pausedAt
          ? _value.pausedAt
          : pausedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      currentCycleDays: null == currentCycleDays
          ? _value.currentCycleDays
          : currentCycleDays // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleCleaned: null == currentCycleCleaned
          ? _value.currentCycleCleaned
          : currentCycleCleaned // ignore: cast_nullable_to_non_nullable
              as int,
      currentCycleMissed: null == currentCycleMissed
          ? _value.currentCycleMissed
          : currentCycleMissed // ignore: cast_nullable_to_non_nullable
              as int,
      totalCycles: null == totalCycles
          ? _value.totalCycles
          : totalCycles // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysCleaned: null == totalDaysCleaned
          ? _value.totalDaysCleaned
          : totalDaysCleaned // ignore: cast_nullable_to_non_nullable
              as int,
      totalDaysMissed: null == totalDaysMissed
          ? _value.totalDaysMissed
          : totalDaysMissed // ignore: cast_nullable_to_non_nullable
              as int,
      previousPlanId: freezed == previousPlanId
          ? _value.previousPlanId
          : previousPlanId // ignore: cast_nullable_to_non_nullable
              as String?,
      lastPlanChangeDate: freezed == lastPlanChangeDate
          ? _value.lastPlanChangeDate
          : lastPlanChangeDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionImpl implements _Subscription {
  const _$SubscriptionImpl(
      {required this.id,
      required this.customerId,
      required this.planId,
      required this.areaId,
      required this.vehicleType,
      this.razorpaySubscriptionId,
      this.razorpayCustomerId,
      this.status = 'active',
      @TimestampConverter() required this.startDate,
      @TimestampConverter() required this.currentPeriodStart,
      @TimestampConverter() required this.currentPeriodEnd,
      @TimestampConverter() this.cancelledAt,
      @TimestampConverter() this.pausedAt,
      this.currentCycleDays = 0,
      this.currentCycleCleaned = 0,
      this.currentCycleMissed = 0,
      this.totalCycles = 0,
      this.totalDaysCleaned = 0,
      this.totalDaysMissed = 0,
      this.previousPlanId,
      @TimestampConverter() this.lastPlanChangeDate,
      @TimestampConverter() required this.createdAt,
      @TimestampConverter() this.updatedAt});

  factory _$SubscriptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionImplFromJson(json);

  @override
  final String id;
// Firestore document ID
  @override
  final String customerId;
// Reference to customer
  @override
  final String planId;
// Razorpay plan ID
  @override
  final String areaId;
// Service area
  @override
  final String vehicleType;
// 'hatchback' | 'sedan' | 'suv'
// Razorpay data
  @override
  final String? razorpaySubscriptionId;
// From Razorpay webhook
  @override
  final String? razorpayCustomerId;
// From Razorpay
// Status: 'active' | 'cancelled' | 'paused' | 'overdue' | 'expired'
  @override
  @JsonKey()
  final String status;
// Billing cycle
  @override
  @TimestampConverter()
  final DateTime startDate;
  @override
  @TimestampConverter()
  final DateTime currentPeriodStart;
  @override
  @TimestampConverter()
  final DateTime currentPeriodEnd;
  @override
  @TimestampConverter()
  final DateTime? cancelledAt;
  @override
  @TimestampConverter()
  final DateTime? pausedAt;
// Cycle stats (reset monthly)
  @override
  @JsonKey()
  final int currentCycleDays;
// Days since current period start
  @override
  @JsonKey()
  final int currentCycleCleaned;
// Cleanings completed this cycle
  @override
  @JsonKey()
  final int currentCycleMissed;
// Cleanings missed this cycle
// Lifetime stats (never reset)
  @override
  @JsonKey()
  final int totalCycles;
// Number of billing cycles completed
  @override
  @JsonKey()
  final int totalDaysCleaned;
// All-time cleanings
  @override
  @JsonKey()
  final int totalDaysMissed;
// All-time missed
// Plan change tracking
  @override
  final String? previousPlanId;
// For downgrades/upgrades
  @override
  @TimestampConverter()
  final DateTime? lastPlanChangeDate;
// Metadata
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Subscription(id: $id, customerId: $customerId, planId: $planId, areaId: $areaId, vehicleType: $vehicleType, razorpaySubscriptionId: $razorpaySubscriptionId, razorpayCustomerId: $razorpayCustomerId, status: $status, startDate: $startDate, currentPeriodStart: $currentPeriodStart, currentPeriodEnd: $currentPeriodEnd, cancelledAt: $cancelledAt, pausedAt: $pausedAt, currentCycleDays: $currentCycleDays, currentCycleCleaned: $currentCycleCleaned, currentCycleMissed: $currentCycleMissed, totalCycles: $totalCycles, totalDaysCleaned: $totalDaysCleaned, totalDaysMissed: $totalDaysMissed, previousPlanId: $previousPlanId, lastPlanChangeDate: $lastPlanChangeDate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.planId, planId) || other.planId == planId) &&
            (identical(other.areaId, areaId) || other.areaId == areaId) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.razorpaySubscriptionId, razorpaySubscriptionId) ||
                other.razorpaySubscriptionId == razorpaySubscriptionId) &&
            (identical(other.razorpayCustomerId, razorpayCustomerId) ||
                other.razorpayCustomerId == razorpayCustomerId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.currentPeriodStart, currentPeriodStart) ||
                other.currentPeriodStart == currentPeriodStart) &&
            (identical(other.currentPeriodEnd, currentPeriodEnd) ||
                other.currentPeriodEnd == currentPeriodEnd) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.pausedAt, pausedAt) ||
                other.pausedAt == pausedAt) &&
            (identical(other.currentCycleDays, currentCycleDays) ||
                other.currentCycleDays == currentCycleDays) &&
            (identical(other.currentCycleCleaned, currentCycleCleaned) ||
                other.currentCycleCleaned == currentCycleCleaned) &&
            (identical(other.currentCycleMissed, currentCycleMissed) ||
                other.currentCycleMissed == currentCycleMissed) &&
            (identical(other.totalCycles, totalCycles) ||
                other.totalCycles == totalCycles) &&
            (identical(other.totalDaysCleaned, totalDaysCleaned) ||
                other.totalDaysCleaned == totalDaysCleaned) &&
            (identical(other.totalDaysMissed, totalDaysMissed) ||
                other.totalDaysMissed == totalDaysMissed) &&
            (identical(other.previousPlanId, previousPlanId) ||
                other.previousPlanId == previousPlanId) &&
            (identical(other.lastPlanChangeDate, lastPlanChangeDate) ||
                other.lastPlanChangeDate == lastPlanChangeDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        customerId,
        planId,
        areaId,
        vehicleType,
        razorpaySubscriptionId,
        razorpayCustomerId,
        status,
        startDate,
        currentPeriodStart,
        currentPeriodEnd,
        cancelledAt,
        pausedAt,
        currentCycleDays,
        currentCycleCleaned,
        currentCycleMissed,
        totalCycles,
        totalDaysCleaned,
        totalDaysMissed,
        previousPlanId,
        lastPlanChangeDate,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      __$$SubscriptionImplCopyWithImpl<_$SubscriptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionImplToJson(
      this,
    );
  }
}

abstract class _Subscription implements Subscription {
  const factory _Subscription(
      {required final String id,
      required final String customerId,
      required final String planId,
      required final String areaId,
      required final String vehicleType,
      final String? razorpaySubscriptionId,
      final String? razorpayCustomerId,
      final String status,
      @TimestampConverter() required final DateTime startDate,
      @TimestampConverter() required final DateTime currentPeriodStart,
      @TimestampConverter() required final DateTime currentPeriodEnd,
      @TimestampConverter() final DateTime? cancelledAt,
      @TimestampConverter() final DateTime? pausedAt,
      final int currentCycleDays,
      final int currentCycleCleaned,
      final int currentCycleMissed,
      final int totalCycles,
      final int totalDaysCleaned,
      final int totalDaysMissed,
      final String? previousPlanId,
      @TimestampConverter() final DateTime? lastPlanChangeDate,
      @TimestampConverter() required final DateTime createdAt,
      @TimestampConverter() final DateTime? updatedAt}) = _$SubscriptionImpl;

  factory _Subscription.fromJson(Map<String, dynamic> json) =
      _$SubscriptionImpl.fromJson;

  @override
  String get id; // Firestore document ID
  @override
  String get customerId; // Reference to customer
  @override
  String get planId; // Razorpay plan ID
  @override
  String get areaId; // Service area
  @override
  String get vehicleType; // 'hatchback' | 'sedan' | 'suv'
// Razorpay data
  @override
  String? get razorpaySubscriptionId; // From Razorpay webhook
  @override
  String? get razorpayCustomerId; // From Razorpay
// Status: 'active' | 'cancelled' | 'paused' | 'overdue' | 'expired'
  @override
  String get status; // Billing cycle
  @override
  @TimestampConverter()
  DateTime get startDate;
  @override
  @TimestampConverter()
  DateTime get currentPeriodStart;
  @override
  @TimestampConverter()
  DateTime get currentPeriodEnd;
  @override
  @TimestampConverter()
  DateTime? get cancelledAt;
  @override
  @TimestampConverter()
  DateTime? get pausedAt; // Cycle stats (reset monthly)
  @override
  int get currentCycleDays; // Days since current period start
  @override
  int get currentCycleCleaned; // Cleanings completed this cycle
  @override
  int get currentCycleMissed; // Cleanings missed this cycle
// Lifetime stats (never reset)
  @override
  int get totalCycles; // Number of billing cycles completed
  @override
  int get totalDaysCleaned; // All-time cleanings
  @override
  int get totalDaysMissed; // All-time missed
// Plan change tracking
  @override
  String? get previousPlanId; // For downgrades/upgrades
  @override
  @TimestampConverter()
  DateTime? get lastPlanChangeDate; // Metadata
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of Subscription
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionImplCopyWith<_$SubscriptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscriptionHistory _$SubscriptionHistoryFromJson(Map<String, dynamic> json) {
  return _SubscriptionHistory.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionHistory {
  String get id => throw _privateConstructorUsedError;
  String get subscriptionId => throw _privateConstructorUsedError;
  String get customerId => throw _privateConstructorUsedError; // What changed
  String get eventType =>
      throw _privateConstructorUsedError; // 'created' | 'plan_changed' | 'cancelled' | 'renewed' | 'paused' | 'resumed'
  Map<String, dynamic> get changes =>
      throw _privateConstructorUsedError; // What was updated
// Context
  String? get reason =>
      throw _privateConstructorUsedError; // Why it changed (user request, payment failure, etc.)
  String? get initiatedBy =>
      throw _privateConstructorUsedError; // 'customer' | 'admin' | 'system'
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionHistoryCopyWith<SubscriptionHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionHistoryCopyWith<$Res> {
  factory $SubscriptionHistoryCopyWith(
          SubscriptionHistory value, $Res Function(SubscriptionHistory) then) =
      _$SubscriptionHistoryCopyWithImpl<$Res, SubscriptionHistory>;
  @useResult
  $Res call(
      {String id,
      String subscriptionId,
      String customerId,
      String eventType,
      Map<String, dynamic> changes,
      String? reason,
      String? initiatedBy,
      @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class _$SubscriptionHistoryCopyWithImpl<$Res, $Val extends SubscriptionHistory>
    implements $SubscriptionHistoryCopyWith<$Res> {
  _$SubscriptionHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subscriptionId = null,
    Object? customerId = null,
    Object? eventType = null,
    Object? changes = null,
    Object? reason = freezed,
    Object? initiatedBy = freezed,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      changes: null == changes
          ? _value.changes
          : changes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedBy: freezed == initiatedBy
          ? _value.initiatedBy
          : initiatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionHistoryImplCopyWith<$Res>
    implements $SubscriptionHistoryCopyWith<$Res> {
  factory _$$SubscriptionHistoryImplCopyWith(_$SubscriptionHistoryImpl value,
          $Res Function(_$SubscriptionHistoryImpl) then) =
      __$$SubscriptionHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String subscriptionId,
      String customerId,
      String eventType,
      Map<String, dynamic> changes,
      String? reason,
      String? initiatedBy,
      @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class __$$SubscriptionHistoryImplCopyWithImpl<$Res>
    extends _$SubscriptionHistoryCopyWithImpl<$Res, _$SubscriptionHistoryImpl>
    implements _$$SubscriptionHistoryImplCopyWith<$Res> {
  __$$SubscriptionHistoryImplCopyWithImpl(_$SubscriptionHistoryImpl _value,
      $Res Function(_$SubscriptionHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? subscriptionId = null,
    Object? customerId = null,
    Object? eventType = null,
    Object? changes = null,
    Object? reason = freezed,
    Object? initiatedBy = freezed,
    Object? timestamp = null,
  }) {
    return _then(_$SubscriptionHistoryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      subscriptionId: null == subscriptionId
          ? _value.subscriptionId
          : subscriptionId // ignore: cast_nullable_to_non_nullable
              as String,
      customerId: null == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as String,
      eventType: null == eventType
          ? _value.eventType
          : eventType // ignore: cast_nullable_to_non_nullable
              as String,
      changes: null == changes
          ? _value._changes
          : changes // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
      initiatedBy: freezed == initiatedBy
          ? _value.initiatedBy
          : initiatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionHistoryImpl implements _SubscriptionHistory {
  const _$SubscriptionHistoryImpl(
      {required this.id,
      required this.subscriptionId,
      required this.customerId,
      required this.eventType,
      required final Map<String, dynamic> changes,
      this.reason,
      this.initiatedBy,
      @TimestampConverter() required this.timestamp})
      : _changes = changes;

  factory _$SubscriptionHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionHistoryImplFromJson(json);

  @override
  final String id;
  @override
  final String subscriptionId;
  @override
  final String customerId;
// What changed
  @override
  final String eventType;
// 'created' | 'plan_changed' | 'cancelled' | 'renewed' | 'paused' | 'resumed'
  final Map<String, dynamic> _changes;
// 'created' | 'plan_changed' | 'cancelled' | 'renewed' | 'paused' | 'resumed'
  @override
  Map<String, dynamic> get changes {
    if (_changes is EqualUnmodifiableMapView) return _changes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_changes);
  }

// What was updated
// Context
  @override
  final String? reason;
// Why it changed (user request, payment failure, etc.)
  @override
  final String? initiatedBy;
// 'customer' | 'admin' | 'system'
  @override
  @TimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'SubscriptionHistory(id: $id, subscriptionId: $subscriptionId, customerId: $customerId, eventType: $eventType, changes: $changes, reason: $reason, initiatedBy: $initiatedBy, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.subscriptionId, subscriptionId) ||
                other.subscriptionId == subscriptionId) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            const DeepCollectionEquality().equals(other._changes, _changes) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.initiatedBy, initiatedBy) ||
                other.initiatedBy == initiatedBy) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      subscriptionId,
      customerId,
      eventType,
      const DeepCollectionEquality().hash(_changes),
      reason,
      initiatedBy,
      timestamp);

  /// Create a copy of SubscriptionHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionHistoryImplCopyWith<_$SubscriptionHistoryImpl> get copyWith =>
      __$$SubscriptionHistoryImplCopyWithImpl<_$SubscriptionHistoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionHistoryImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionHistory implements SubscriptionHistory {
  const factory _SubscriptionHistory(
          {required final String id,
          required final String subscriptionId,
          required final String customerId,
          required final String eventType,
          required final Map<String, dynamic> changes,
          final String? reason,
          final String? initiatedBy,
          @TimestampConverter() required final DateTime timestamp}) =
      _$SubscriptionHistoryImpl;

  factory _SubscriptionHistory.fromJson(Map<String, dynamic> json) =
      _$SubscriptionHistoryImpl.fromJson;

  @override
  String get id;
  @override
  String get subscriptionId;
  @override
  String get customerId; // What changed
  @override
  String
      get eventType; // 'created' | 'plan_changed' | 'cancelled' | 'renewed' | 'paused' | 'resumed'
  @override
  Map<String, dynamic> get changes; // What was updated
// Context
  @override
  String? get reason; // Why it changed (user request, payment failure, etc.)
  @override
  String? get initiatedBy; // 'customer' | 'admin' | 'system'
  @override
  @TimestampConverter()
  DateTime get timestamp;

  /// Create a copy of SubscriptionHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionHistoryImplCopyWith<_$SubscriptionHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
