// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  String get id =>
      throw _privateConstructorUsedError; // Auto-generated Firestore doc ID
  String get userId =>
      throw _privateConstructorUsedError; // Firebase Auth UID of the owning user
  String? get label =>
      throw _privateConstructorUsedError; // Optional display name, e.g. "White Honda City"
  String get address =>
      throw _privateConstructorUsedError; // Full address as string
  @GeoPointConverter()
  GeoPoint get geopoint =>
      throw _privateConstructorUsedError; // For location-based features
  String get vehicleType =>
      throw _privateConstructorUsedError; // 'hatchback' | 'sedan' | 'suv'
  String get plateCode => throw _privateConstructorUsedError; // Last 6 digits
  String get vehicleModel => throw _privateConstructorUsedError;
  String? get assignedStaffId =>
      throw _privateConstructorUsedError; // Subscription reference (for quick access)
  String? get activeSubscriptionId =>
      throw _privateConstructorUsedError; // Current subscription ID
  String get subscriptionStatus =>
      throw _privateConstructorUsedError; // 'active' | 'inactive' | 'cancelled' | 'paused'
// Denormalized for quick display (synced from Subscription)
  String? get currentPlanId => throw _privateConstructorUsedError;
  String? get currentAreaId => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get currentPeriodEnd =>
      throw _privateConstructorUsedError; // For "X days remaining" display
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Customer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String? label,
      String address,
      @GeoPointConverter() GeoPoint geopoint,
      String vehicleType,
      String plateCode,
      String vehicleModel,
      String? assignedStaffId,
      String? activeSubscriptionId,
      String subscriptionStatus,
      String? currentPlanId,
      String? currentAreaId,
      @TimestampConverter() DateTime? currentPeriodEnd,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = freezed,
    Object? address = null,
    Object? geopoint = null,
    Object? vehicleType = null,
    Object? plateCode = null,
    Object? vehicleModel = null,
    Object? assignedStaffId = freezed,
    Object? activeSubscriptionId = freezed,
    Object? subscriptionStatus = null,
    Object? currentPlanId = freezed,
    Object? currentAreaId = freezed,
    Object? currentPeriodEnd = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geopoint: null == geopoint
          ? _value.geopoint
          : geopoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      plateCode: null == plateCode
          ? _value.plateCode
          : plateCode // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleModel: null == vehicleModel
          ? _value.vehicleModel
          : vehicleModel // ignore: cast_nullable_to_non_nullable
              as String,
      assignedStaffId: freezed == assignedStaffId
          ? _value.assignedStaffId
          : assignedStaffId // ignore: cast_nullable_to_non_nullable
              as String?,
      activeSubscriptionId: freezed == activeSubscriptionId
          ? _value.activeSubscriptionId
          : activeSubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlanId: freezed == currentPlanId
          ? _value.currentPlanId
          : currentPlanId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentAreaId: freezed == currentAreaId
          ? _value.currentAreaId
          : currentAreaId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPeriodEnd: freezed == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String? label,
      String address,
      @GeoPointConverter() GeoPoint geopoint,
      String vehicleType,
      String plateCode,
      String vehicleModel,
      String? assignedStaffId,
      String? activeSubscriptionId,
      String subscriptionStatus,
      String? currentPlanId,
      String? currentAreaId,
      @TimestampConverter() DateTime? currentPeriodEnd,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? label = freezed,
    Object? address = null,
    Object? geopoint = null,
    Object? vehicleType = null,
    Object? plateCode = null,
    Object? vehicleModel = null,
    Object? assignedStaffId = freezed,
    Object? activeSubscriptionId = freezed,
    Object? subscriptionStatus = null,
    Object? currentPlanId = freezed,
    Object? currentAreaId = freezed,
    Object? currentPeriodEnd = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$CustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      geopoint: null == geopoint
          ? _value.geopoint
          : geopoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint,
      vehicleType: null == vehicleType
          ? _value.vehicleType
          : vehicleType // ignore: cast_nullable_to_non_nullable
              as String,
      plateCode: null == plateCode
          ? _value.plateCode
          : plateCode // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleModel: null == vehicleModel
          ? _value.vehicleModel
          : vehicleModel // ignore: cast_nullable_to_non_nullable
              as String,
      assignedStaffId: freezed == assignedStaffId
          ? _value.assignedStaffId
          : assignedStaffId // ignore: cast_nullable_to_non_nullable
              as String?,
      activeSubscriptionId: freezed == activeSubscriptionId
          ? _value.activeSubscriptionId
          : activeSubscriptionId // ignore: cast_nullable_to_non_nullable
              as String?,
      subscriptionStatus: null == subscriptionStatus
          ? _value.subscriptionStatus
          : subscriptionStatus // ignore: cast_nullable_to_non_nullable
              as String,
      currentPlanId: freezed == currentPlanId
          ? _value.currentPlanId
          : currentPlanId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentAreaId: freezed == currentAreaId
          ? _value.currentAreaId
          : currentAreaId // ignore: cast_nullable_to_non_nullable
              as String?,
      currentPeriodEnd: freezed == currentPeriodEnd
          ? _value.currentPeriodEnd
          : currentPeriodEnd // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl implements _Customer {
  const _$CustomerImpl(
      {required this.id,
      required this.userId,
      this.label,
      this.address = '',
      @GeoPointConverter() this.geopoint = const GeoPoint(0, 0),
      this.vehicleType = 'sedan',
      this.plateCode = '',
      this.vehicleModel = '',
      this.assignedStaffId,
      this.activeSubscriptionId,
      this.subscriptionStatus = 'inactive',
      this.currentPlanId,
      this.currentAreaId,
      @TimestampConverter() this.currentPeriodEnd,
      @TimestampConverter() this.createdAt});

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final String id;
// Auto-generated Firestore doc ID
  @override
  final String userId;
// Firebase Auth UID of the owning user
  @override
  final String? label;
// Optional display name, e.g. "White Honda City"
  @override
  @JsonKey()
  final String address;
// Full address as string
  @override
  @JsonKey()
  @GeoPointConverter()
  final GeoPoint geopoint;
// For location-based features
  @override
  @JsonKey()
  final String vehicleType;
// 'hatchback' | 'sedan' | 'suv'
  @override
  @JsonKey()
  final String plateCode;
// Last 6 digits
  @override
  @JsonKey()
  final String vehicleModel;
  @override
  final String? assignedStaffId;
// Subscription reference (for quick access)
  @override
  final String? activeSubscriptionId;
// Current subscription ID
  @override
  @JsonKey()
  final String subscriptionStatus;
// 'active' | 'inactive' | 'cancelled' | 'paused'
// Denormalized for quick display (synced from Subscription)
  @override
  final String? currentPlanId;
  @override
  final String? currentAreaId;
  @override
  @TimestampConverter()
  final DateTime? currentPeriodEnd;
// For "X days remaining" display
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Customer(id: $id, userId: $userId, label: $label, address: $address, geopoint: $geopoint, vehicleType: $vehicleType, plateCode: $plateCode, vehicleModel: $vehicleModel, assignedStaffId: $assignedStaffId, activeSubscriptionId: $activeSubscriptionId, subscriptionStatus: $subscriptionStatus, currentPlanId: $currentPlanId, currentAreaId: $currentAreaId, currentPeriodEnd: $currentPeriodEnd, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.geopoint, geopoint) ||
                other.geopoint == geopoint) &&
            (identical(other.vehicleType, vehicleType) ||
                other.vehicleType == vehicleType) &&
            (identical(other.plateCode, plateCode) ||
                other.plateCode == plateCode) &&
            (identical(other.vehicleModel, vehicleModel) ||
                other.vehicleModel == vehicleModel) &&
            (identical(other.assignedStaffId, assignedStaffId) ||
                other.assignedStaffId == assignedStaffId) &&
            (identical(other.activeSubscriptionId, activeSubscriptionId) ||
                other.activeSubscriptionId == activeSubscriptionId) &&
            (identical(other.subscriptionStatus, subscriptionStatus) ||
                other.subscriptionStatus == subscriptionStatus) &&
            (identical(other.currentPlanId, currentPlanId) ||
                other.currentPlanId == currentPlanId) &&
            (identical(other.currentAreaId, currentAreaId) ||
                other.currentAreaId == currentAreaId) &&
            (identical(other.currentPeriodEnd, currentPeriodEnd) ||
                other.currentPeriodEnd == currentPeriodEnd) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      label,
      address,
      geopoint,
      vehicleType,
      plateCode,
      vehicleModel,
      assignedStaffId,
      activeSubscriptionId,
      subscriptionStatus,
      currentPlanId,
      currentAreaId,
      currentPeriodEnd,
      createdAt);

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer implements Customer {
  const factory _Customer(
      {required final String id,
      required final String userId,
      final String? label,
      final String address,
      @GeoPointConverter() final GeoPoint geopoint,
      final String vehicleType,
      final String plateCode,
      final String vehicleModel,
      final String? assignedStaffId,
      final String? activeSubscriptionId,
      final String subscriptionStatus,
      final String? currentPlanId,
      final String? currentAreaId,
      @TimestampConverter() final DateTime? currentPeriodEnd,
      @TimestampConverter() final DateTime? createdAt}) = _$CustomerImpl;

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  String get id; // Auto-generated Firestore doc ID
  @override
  String get userId; // Firebase Auth UID of the owning user
  @override
  String? get label; // Optional display name, e.g. "White Honda City"
  @override
  String get address; // Full address as string
  @override
  @GeoPointConverter()
  GeoPoint get geopoint; // For location-based features
  @override
  String get vehicleType; // 'hatchback' | 'sedan' | 'suv'
  @override
  String get plateCode; // Last 6 digits
  @override
  String get vehicleModel;
  @override
  String? get assignedStaffId; // Subscription reference (for quick access)
  @override
  String? get activeSubscriptionId; // Current subscription ID
  @override
  String
      get subscriptionStatus; // 'active' | 'inactive' | 'cancelled' | 'paused'
// Denormalized for quick display (synced from Subscription)
  @override
  String? get currentPlanId;
  @override
  String? get currentAreaId;
  @override
  @TimestampConverter()
  DateTime? get currentPeriodEnd; // For "X days remaining" display
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of Customer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
