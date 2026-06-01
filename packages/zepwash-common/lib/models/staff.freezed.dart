// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'staff.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Staff _$StaffFromJson(Map<String, dynamic> json) {
  return _Staff.fromJson(json);
}

/// @nodoc
mixin _$Staff {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get assignedAreaId => throw _privateConstructorUsedError;
  bool get isAvailable => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  int get dailyRate => throw _privateConstructorUsedError; // Per car per day
  int get assignedCustomersCount => throw _privateConstructorUsedError;
  double get currentMonthSalary => throw _privateConstructorUsedError;
  int get currentMonthCleanings => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String? get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this Staff to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StaffCopyWith<Staff> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StaffCopyWith<$Res> {
  factory $StaffCopyWith(Staff value, $Res Function(Staff) then) =
      _$StaffCopyWithImpl<$Res, Staff>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String phone,
      String assignedAreaId,
      bool isAvailable,
      bool isVerified,
      int dailyRate,
      int assignedCustomersCount,
      double currentMonthSalary,
      int currentMonthCleanings,
      @TimestampConverter() DateTime createdAt,
      String? fcmToken});
}

/// @nodoc
class _$StaffCopyWithImpl<$Res, $Val extends Staff>
    implements $StaffCopyWith<$Res> {
  _$StaffCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? phone = null,
    Object? assignedAreaId = null,
    Object? isAvailable = null,
    Object? isVerified = null,
    Object? dailyRate = null,
    Object? assignedCustomersCount = null,
    Object? currentMonthSalary = null,
    Object? currentMonthCleanings = null,
    Object? createdAt = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      assignedAreaId: null == assignedAreaId
          ? _value.assignedAreaId
          : assignedAreaId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyRate: null == dailyRate
          ? _value.dailyRate
          : dailyRate // ignore: cast_nullable_to_non_nullable
              as int,
      assignedCustomersCount: null == assignedCustomersCount
          ? _value.assignedCustomersCount
          : assignedCustomersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentMonthSalary: null == currentMonthSalary
          ? _value.currentMonthSalary
          : currentMonthSalary // ignore: cast_nullable_to_non_nullable
              as double,
      currentMonthCleanings: null == currentMonthCleanings
          ? _value.currentMonthCleanings
          : currentMonthCleanings // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StaffImplCopyWith<$Res> implements $StaffCopyWith<$Res> {
  factory _$$StaffImplCopyWith(
          _$StaffImpl value, $Res Function(_$StaffImpl) then) =
      __$$StaffImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String phone,
      String assignedAreaId,
      bool isAvailable,
      bool isVerified,
      int dailyRate,
      int assignedCustomersCount,
      double currentMonthSalary,
      int currentMonthCleanings,
      @TimestampConverter() DateTime createdAt,
      String? fcmToken});
}

/// @nodoc
class __$$StaffImplCopyWithImpl<$Res>
    extends _$StaffCopyWithImpl<$Res, _$StaffImpl>
    implements _$$StaffImplCopyWith<$Res> {
  __$$StaffImplCopyWithImpl(
      _$StaffImpl _value, $Res Function(_$StaffImpl) _then)
      : super(_value, _then);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? phone = null,
    Object? assignedAreaId = null,
    Object? isAvailable = null,
    Object? isVerified = null,
    Object? dailyRate = null,
    Object? assignedCustomersCount = null,
    Object? currentMonthSalary = null,
    Object? currentMonthCleanings = null,
    Object? createdAt = null,
    Object? fcmToken = freezed,
  }) {
    return _then(_$StaffImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      assignedAreaId: null == assignedAreaId
          ? _value.assignedAreaId
          : assignedAreaId // ignore: cast_nullable_to_non_nullable
              as String,
      isAvailable: null == isAvailable
          ? _value.isAvailable
          : isAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      dailyRate: null == dailyRate
          ? _value.dailyRate
          : dailyRate // ignore: cast_nullable_to_non_nullable
              as int,
      assignedCustomersCount: null == assignedCustomersCount
          ? _value.assignedCustomersCount
          : assignedCustomersCount // ignore: cast_nullable_to_non_nullable
              as int,
      currentMonthSalary: null == currentMonthSalary
          ? _value.currentMonthSalary
          : currentMonthSalary // ignore: cast_nullable_to_non_nullable
              as double,
      currentMonthCleanings: null == currentMonthCleanings
          ? _value.currentMonthCleanings
          : currentMonthCleanings // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StaffImpl implements _Staff {
  const _$StaffImpl(
      {required this.uid,
      this.name = 'Unknown Staff',
      this.phone = '',
      this.assignedAreaId = '',
      this.isAvailable = true,
      this.isVerified = false,
      this.dailyRate = 0,
      this.assignedCustomersCount = 0,
      this.currentMonthSalary = 0.0,
      this.currentMonthCleanings = 0,
      @TimestampConverter() required this.createdAt,
      this.fcmToken});

  factory _$StaffImpl.fromJson(Map<String, dynamic> json) =>
      _$$StaffImplFromJson(json);

  @override
  final String uid;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String phone;
  @override
  @JsonKey()
  final String assignedAreaId;
  @override
  @JsonKey()
  final bool isAvailable;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final int dailyRate;
// Per car per day
  @override
  @JsonKey()
  final int assignedCustomersCount;
  @override
  @JsonKey()
  final double currentMonthSalary;
  @override
  @JsonKey()
  final int currentMonthCleanings;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  final String? fcmToken;

  @override
  String toString() {
    return 'Staff(uid: $uid, name: $name, phone: $phone, assignedAreaId: $assignedAreaId, isAvailable: $isAvailable, isVerified: $isVerified, dailyRate: $dailyRate, assignedCustomersCount: $assignedCustomersCount, currentMonthSalary: $currentMonthSalary, currentMonthCleanings: $currentMonthCleanings, createdAt: $createdAt, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StaffImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.assignedAreaId, assignedAreaId) ||
                other.assignedAreaId == assignedAreaId) &&
            (identical(other.isAvailable, isAvailable) ||
                other.isAvailable == isAvailable) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.dailyRate, dailyRate) ||
                other.dailyRate == dailyRate) &&
            (identical(other.assignedCustomersCount, assignedCustomersCount) ||
                other.assignedCustomersCount == assignedCustomersCount) &&
            (identical(other.currentMonthSalary, currentMonthSalary) ||
                other.currentMonthSalary == currentMonthSalary) &&
            (identical(other.currentMonthCleanings, currentMonthCleanings) ||
                other.currentMonthCleanings == currentMonthCleanings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      name,
      phone,
      assignedAreaId,
      isAvailable,
      isVerified,
      dailyRate,
      assignedCustomersCount,
      currentMonthSalary,
      currentMonthCleanings,
      createdAt,
      fcmToken);

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      __$$StaffImplCopyWithImpl<_$StaffImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StaffImplToJson(
      this,
    );
  }
}

abstract class _Staff implements Staff {
  const factory _Staff(
      {required final String uid,
      final String name,
      final String phone,
      final String assignedAreaId,
      final bool isAvailable,
      final bool isVerified,
      final int dailyRate,
      final int assignedCustomersCount,
      final double currentMonthSalary,
      final int currentMonthCleanings,
      @TimestampConverter() required final DateTime createdAt,
      final String? fcmToken}) = _$StaffImpl;

  factory _Staff.fromJson(Map<String, dynamic> json) = _$StaffImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get phone;
  @override
  String get assignedAreaId;
  @override
  bool get isAvailable;
  @override
  bool get isVerified;
  @override
  int get dailyRate; // Per car per day
  @override
  int get assignedCustomersCount;
  @override
  double get currentMonthSalary;
  @override
  int get currentMonthCleanings;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  String? get fcmToken;

  /// Create a copy of Staff
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StaffImplCopyWith<_$StaffImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
